//
//  DetailViewViewController.swift
//  RutePredictor
//
//  Created by Lingeswaran Kandasamy on 7/17/17.
//  Copyright © 2017 Lingeswaran Kandasamy. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
import GoogleMaps
import CoreLocation
import Alamofire

class DetailViewViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
   // @IBOutlet weak var tableView: UITableView!

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
  //  @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
    self.navigationItem.setHidesBackButton(true, animated:true);
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startMonitoringSignificantLocationChanges()
        
    tableView.delegate = self
    tableView.dataSource = self

    currentWeather = CurrentWeather()
    currentWeather.downloadWeatherDetails {
        
    }
    
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Locations.sharedInstance.latitude = currentLocation.coordinate.latitude
            Locations.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
               
                    self.updateMainUI()
                }
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            //let forecast = forecasts[indexPath.row]
           // cell.configureCell(forecast: forecast)
            return cell
       } else {
            return WeatherCell()
        }
        
        }
    
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
     //   locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    
    @IBAction func scheduleTapped(_ sender: Any) {
     performSegue(withIdentifier: "showScheduleView", sender: nil)    
      self.title = ""
    }
    
    
    @IBAction func signOutTapped(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: "KEY_UID")
        print("Lin:\(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "gotoSignin", sender: nil)
    }
    
}

