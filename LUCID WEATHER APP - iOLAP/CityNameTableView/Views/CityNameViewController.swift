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
    
    let names = ["Zagreb", "Požega"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "City"
        CityNameTableView.delegate = self
        CityNameTableView.dataSource = self
//        CityNameTableView.register(CityNameCell.self, forCellReuseIdentifier: "Cell")

        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityNameCell
        cell.CityNameLabel?.text = self.names[indexPath.row]
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
            }
            if let senderLocation = sender as? Double {
                // Send new data location to next screen
            } // later as Location
        }
    }
 

}



    


