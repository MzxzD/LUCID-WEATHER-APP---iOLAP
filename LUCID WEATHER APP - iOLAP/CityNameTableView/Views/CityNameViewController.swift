//
//  CityNameViewController.swift
//  LUCID WEATHER APP - iOLAP
//
//  Created by Mateo Doslic on 03/08/2019.
//  Copyright © 2019 Mateo Doslic. All rights reserved.
//

import UIKit
import CoreLocation

class CityNameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var CityNameTableView: UITableView!
    @IBOutlet weak var locationWeatherButton: UIButton!
    let controller = CityNameController()
    var locationManager = CLLocationManager()
    
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
    

    @IBAction func UseLocationButtonPressed(_ sender: Any) {
        prepareForLocation()
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailWeather" {
            var selectedRowIndex = self.CityNameTableView.indexPathForSelectedRow
            let weatherForecastVC: WeatherForecastViewController = (segue.destination as! WeatherForecastViewController)
            if let senderIndexPath = sender as? IndexPath {
                guard let cities = self.controller.cityNames?.city else {
                    return
                }
                weatherForecastVC.controller.cityName = cities[senderIndexPath.row].name
            }
            if let senderLocation = sender as? (Long: Double, Lati: Double) {
                weatherForecastVC.controller.location.lati = senderLocation.Lati
                weatherForecastVC.controller.location.long = senderLocation.Long
            } // later as Location
        }
    }
 
    
    func prepareForLocation() {
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("User allowed us to access location")
            //do whatever init activities here.
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did location updates is called but failed getting location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let networkManager = AlamofireNetwork()
        
        guard let coordinate = locations.last?.coordinate else { return }
        print(String(coordinate.latitude))
        print(String(coordinate.longitude))
        locationManager.stopUpdatingLocation()
        performSegue(withIdentifier: "DetailWeather", sender: (Long: coordinate.longitude, Lati: coordinate.latitude) )
       
    }
    
    func isAuthorizedtoGetUserLocation() {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    func getLocation() {
        prepareForLocation()
        isAuthorizedtoGetUserLocation()
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.requestLocation();
        }
    }
}



    


