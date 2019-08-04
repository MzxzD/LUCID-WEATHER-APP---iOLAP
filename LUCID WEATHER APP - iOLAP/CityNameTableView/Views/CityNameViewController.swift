//
//  CityNameViewController.swift
//  LUCID WEATHER APP - iOLAP
//
//  Created by Mateo Doslic on 03/08/2019.
//  Copyright © 2019 Mateo Doslic. All rights reserved.
//

import UIKit

class CityNameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var CityNameTableView: UITableView!
    @IBOutlet weak var locationWeatherButton: UIButton!
    let controller = CityNameController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "City"
        self.controller.fetchLocalData()
        CityNameTableView.delegate = self
        CityNameTableView.dataSource = self
 
        CityNameTableView.reloadData()
//        CityNameTableView.register(CityNameCell.self, forCellReuseIdentifier: "Cell")

        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cities = self.controller.cityNames?.city else {
            return 0
            }
        
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityNameCell
//        cell.CityNameLabel?.text = self.names[indexPath.row]
        guard let cities = self.controller.cityNames?.city else {
            return cell
        }
        cell.CityNameLabel?.text = cities[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailWeather", sender: indexPath)
    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailWeather" {
            var selectedRowIndex = self.CityNameTableView.indexPathForSelectedRow
            let weatherForecastVC: WeatherForecastViewController = (segue.destination as! WeatherForecastViewController)
            if let senderIndexPath = sender as? IndexPath {
                // Add a way to send data from this view to another
                guard let cities = self.controller.cityNames?.city else {
                    return
                }
                weatherForecastVC.controller.cityName = cities[senderIndexPath.row].name
            }
            if let senderLocation = sender as? Double {
                // Send new data location to next screen
            } // later as Location
        }
    }
 

}



    


