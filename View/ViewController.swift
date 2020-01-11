//
//  ViewController.swift
//  CocoaSky
//
//  Created by Владислав Лазарев on 17/11/2019.
//  Copyright © 2019 Владислав Лазарев. All rights reserved.
//

import UIKit
import NavigationDropdownMenu


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

  
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tempretureBarItem: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    var isCelsius = false
    var weatherData = [List]()
    
    let items = ["Mexico", "Moscow", "Samara", "Orel"]
    let defaults = UserDefaults.standard

    
    @IBOutlet var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let currentDate = Date()
        let dateForm = DateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd"
        print(currentDate)
        
        // load weather from user defaults
        if let savedWeather = defaults.object(forKey: "SavedWeather") as? Data {
            let decoder = JSONDecoder()
            if let loaderWeather = try? decoder.decode([List].self, from: savedWeather) {
                let calendar = Calendar.current
                let checkDate =  Date.getDateFromString(date: loaderWeather[0].dtTxt)
                if calendar.isDateInToday(checkDate) {
                    weatherData = loaderWeather
                    self.tempLabel.text = String(Int(weatherData[0].main.temp) - 273)
                    self.descriptionLabel.text = weatherData[0].weather[0].weatherDescription.rawValue
                    tableView.reloadData()
                } else {
                    let testUrl = Constants.weatherUrl + "Moskva"
                    
                    NetworkingManager.fetchData(url: testUrl) { [weak self] weather in
                        self?.tempLabel.text = String(Int(weather.list[0].main.temp) - 273)
                        self?.descriptionLabel.text = weather.list[0].weather[0].weatherDescription.rawValue
                        self?.weatherData.append(weather.list[7])
                        self?.weatherData.append(weather.list[15])
                        self?.weatherData.append(weather.list[23])
                        self?.weatherData.append(weather.list[31])
                        
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(self?.weatherData) {
                            self?.defaults.set(encoded, forKey: "SavedWeather")
                        }
                        
                        self?.tableView.reloadData()
                    }
                }
            }
        }
        
        if let typeTemp = defaults.object(forKey: "isCelsius") as? Bool {
            isCelsius = typeTemp
            print(isCelsius)
        }
        
        setupNavBarAndNavController()
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
            self!.weatherData.removeAll()
            let testUrl = Constants.weatherUrl + self!.items[indexPath]
            NetworkingManager.fetchData(url: testUrl) { [weak self] weather in
                self?.tempLabel.text = String(Int(weather.list[0].main.temp) - 273)
                self?.descriptionLabel.text = weather.list[0].weather[0].weatherDescription.rawValue
                self?.weatherData.append(weather.list[7])
                self?.weatherData.append(weather.list[15])
                self?.weatherData.append(weather.list[23])
                self?.weatherData.append(weather.list[31])
                self?.tableView.reloadData()
            }
        }
        
    }

    func setupNavBarAndNavController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        tempretureBarItem.tintColor = .black
        UITabBar.appearance().barTintColor = UIColor.clear
        UITabBar.appearance().backgroundImage = UIImage()
    }

    @IBAction func barButtonClick(_ sender: UIBarButtonItem) {
        let tempreture = Int(weatherData[0].main.temp)
        if isCelsius {
            tempLabel.text = String(tempreture - 273)
            tempretureBarItem.title = "C"
            isCelsius = false
            tableView.reloadData()
            defaults.set(true, forKey: "isCelsius")
        } else {
            tempLabel.text = String(tempreture * 9 / 5 - 459)
            tempretureBarItem.title = "F"
            isCelsius = true
            tableView.reloadData()
            defaults.set(false , forKey: "isCelsius")
        }
        tableView.reloadData()

    }
}
    


//MARK: - UITableViewDelegate

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        let tempreture = Int(weatherData[indexPath.row].main.temp)
        cell.dayLabel.text = Date.getWeekday(date: weatherData[indexPath.row].dtTxt)

        let icon = weatherData[indexPath.row].weather[0].weatherIcon
        cell.imageOfWeather.getWeatherIcon(icon: icon)
        
        if isCelsius {
            cell.tempretureLabel.text = String(tempreture * 9 / 5 - 459)
        } else {
            cell.tempretureLabel.text = String(tempreture - 273)
        }
        
        return cell
    }
}

