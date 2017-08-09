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


    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var destinationLbl: UILabel!
    @IBOutlet weak var destinationImage: CircleView!
    @IBOutlet weak var arrivalDateLbl: UILabel!
    @IBOutlet weak var departureTimeLbl: UILabel!
    @IBOutlet weak var arrivalTimeLbl: UILabel!
    @IBOutlet weak var extraTimeLbl: UILabel!
    @IBOutlet weak var estimateTimeLbl: UILabel!
    @IBOutlet weak var alamTimeLbl: UILabel!
    

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var travelTime: TravelTime!
    
    
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
    travelTime = TravelTime()
        

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Locations.sharedInstance.DestinationLocation == nil {
                print("LIN:NO VALUE")
            } else{
                print("LIN: Destination Location", Locations.sharedInstance.DestinationLocation)
                destinationLbl.text = Locations.sharedInstance.DestinationLocation
                let ds_address = Locations.sharedInstance.DestinationLocation
                let urlNew: String = (ds_address?.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed))!
                Locations.sharedInstance.destinationAddressURL = urlNew
                print("LIN: Destination Location", urlNew)
            }
                locationAuthStatus()
           }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Locations.sharedInstance.latitude = currentLocation.coordinate.latitude
            Locations.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            let location = CLLocation(latitude: Locations.sharedInstance.latitude, longitude: Locations.sharedInstance.longitude)
            fetchCountryAndCity(location: location) { country, city, state, postalCode, street in
                print("country:", country)
                print("city:", city)
                print("State:", state)
                print("postal Code:", postalCode)
                print("street:", street)
                let address = "\(street),\(city),\(state),\(postalCode)"
                print("The Address is:", address)
                let currentaddress: String = (address.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed))!
                Locations.sharedInstance.currentAddress = currentaddress
            }
            currentWeather.downloadWeatherDetails {
                if Locations.sharedInstance.destinationAddressURL != nil{
                    self.downloadTravelTimeData {
                    self.updateMainUI()
                    }
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    func downloadTravelTimeData(completed: @escaping DownloadComplete) {
        //Downloading forecast weather data for TableView
        Alamofire.request(GOOGLE_DISTANCEMATRICS_URL).responseJSON { response in
            let result = response.result
            
            print("LIN: Please load DATA", response)
            
            if let dict = result.value as? Dictionary<String, Any> {
                
                if let list = dict["rows"] as? [Dictionary<String, Any>] {
                    
                    if let elements = list[0]["elements"] as? [Dictionary<String, Any>]{
                        
                        if let duration = elements[0]["duration"] as? Dictionary<String, Any>{
                            
                            let text = duration["text"] as? String
                            
                            self.estimateTimeLbl.text = text
                            print("LIN: Please load DATA:", self.estimateTimeLbl)
                        }
                        
                    }
                    
                }
            }
            
        }
        completed()
    }

    
    func fetchCountryAndCity(location: CLLocation, completion: @escaping (String, String, String, String, String) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print(error)
            } else if let country = placemarks?.first?.addressDictionary?["Name"] as? String,
                let city = placemarks?.first?.locality,
                let state = placemarks?.first?.administrativeArea,
                let postalCode = placemarks?.first?.postalCode,
                let street = placemarks?.first?.thoroughfare {
                completion(country, city, state, postalCode, street)
            }
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
            
                    return cell
                }else {
                return WeatherCell()
                }
        }

    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        estimateTimeLbl.text = travelTime.estimateArrivalTime
        
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

