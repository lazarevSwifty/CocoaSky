//
//  ViewController.swift
//  CocoaSky
//
//  Created by Владислав Лазарев on 17/11/2019.
//  Copyright © 2019 Владислав Лазарев. All rights reserved.
//

import UIKit
import NavigationDropdownMenu


class ViewController: UIViewController {
    
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tempretureBarItem: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var selectedIndex = 0
    
    var weatherCurrent: UniversalWeatherTemperature?
    var weatherList = [UniversalWeatherTemperature]()
    
    let items = ["Mexico", "Moscow", "Samara", "Orel"]
    
    @IBOutlet var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        setupNavBarAndNavControllerStyle()
        preloadWeatherData()
        setupDropdownMenu()
    }
    
    func setupDropdownMenu() {
        let menuView = NavigationDropdownMenu(title: Title.index(1), items: items)
        navigationItem.titleView = menuView
        
        menuView.animationDuration = 0.3
        menuView.maskBackgroundOpacity = 0.8
        menuView.cellTextLabelAlignment = .center
        menuView.cellTextLabelFont = UIFont.systemFont(ofSize: 18)
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellBackgroundColor = #colorLiteral(red: 0.1490027606, green: 0.1490303874, blue: 0.1489966214, alpha: 0.2467264525)
        menuView.cellSelectionColor =  #colorLiteral(red: 0.1490027606, green: 0.1490303874, blue: 0.1489966214, alpha: 0.2467264525)
        menuView.cellTextLabelColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
        menuView.cellSeparatorColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 0.5102057658)
        
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            let url = Constants.weatherUrl + self!.items[indexPath]
            self?.updateWeatherAndReloadData(fromURL: url) {
                UserSettings.setSelectedIndex(indexPath)
            }
        }
        
    }
    
    func setupNavBarAndNavControllerStyle() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        tempretureBarItem.tintColor = .black
        UITabBar.appearance().barTintColor = UIColor.clear
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    func preloadWeatherData() {
        let lastWeather = UserSettings.getLastWeather()
        if let lastWeather = lastWeather {
            let calendar = Calendar.current
            if let checkDate = lastWeather.currentTemperature.toDate() {
                if calendar.isDateInToday(checkDate) {
                    self.fillAndReloadData(lastWeather)
                    return
                }
            }
        }
        let testUrl = Constants.weatherUrl + "Moskva"
        self.updateWeatherAndReloadData(fromURL: testUrl)
    }
    
    /// toggle for type of tempreture
    @IBAction func barButtonClick(_ sender: UIBarButtonItem) {
        let newTempType: TemperatureType = UserSettings.getTemperature() == .celsius ? .fahrenheit : .celsius
        UserSettings.setTemperature(newTempType)
        
        let main = self.weatherCurrent
        tempLabel.text = main?.getCurrentTemperature()
        tempretureBarItem.title = main?.getCurrentAttributteTemperature()
        
        tableView.reloadData()
    }
    
    func updateWeatherAndReloadData(fromURL url: String, closure: (() -> ())? = nil){
        NetworkingManager.fetchOpenWeatherMap(url: url) { [weak self] weather in
            self?.fillAndReloadData(weather)
            UserSettings.saveLastWeather(weather)
            closure?()
        }
    }
    
    func fillAndReloadData(_ weather: UniversalWeather) {
        let current = weather.currentTemperature
        self.tempLabel.text = current.getCurrentTemperature()
        self.descriptionLabel.text = current.desc
        self.weatherCurrent = current
        self.weatherList = weather.temperaturesOnAllDay
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        let temp = self.weatherList[indexPath.row]
        cell.dayLabel.text = temp.getWeekday()
        cell.imageOfWeather.setWeatherIcon(icon: temp.icon)
        cell.tempretureLabel.text = temp.getCurrentTemperature()
        
        return cell
    }
}
