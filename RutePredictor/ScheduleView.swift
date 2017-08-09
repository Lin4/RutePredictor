//
//  ScheduleView.swift
//  RutePredictor
//
//  Created by Lingeswaran Kandasamy on 7/25/17.
//  Copyright © 2017 Lingeswaran Kandasamy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import LocationPicker


class ScheduleView: UIViewController {
    
    @IBOutlet weak var alarmTime: UIButton!
    @IBOutlet weak var departuteTime: UIButton!
    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var departuereDate: UIButton!
    @IBOutlet weak var destnationBtn: UIButton!
    var location: Location?
    {
        didSet {
            destnationBtn.setTitle (location.flatMap({ $0.title }) ?? "No location selected", for: .normal)
            Locations.sharedInstance.DestinationLocation = location.flatMap({ $0.title })
       }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.backItem?.title = ""
        let coordinates = CLLocationCoordinate2D(latitude: 43.25, longitude: 76.95)
        location = Location(name: "Where would you like to travel?", location: nil,
                            placemark: MKPlacemark(coordinate: coordinates, addressDictionary: [:]))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LocationPicker" {
            self.title = ""
            let locationPicker = segue.destination as! LocationPickerViewController
            locationPicker.location = location
            locationPicker.showCurrentLocationButton = true
            locationPicker.useCurrentLocationAsHint = true
            locationPicker.showCurrentLocationInitially = true
            locationPicker.completion = { self.location = $0 }
        }
        else if segue.identifier == "DateTimePicker"{
            self.title = ""
            let dateTimePicker = segue.destination as! DatePickerController
            dateTimePicker.callback = {self.departuereDate.setTitle($0, for: .normal)
            }
           
        }
        else if segue.identifier == "AlarmTimePicker"{
            self.title = ""
            let dateTimePicker = segue.destination as! DatePickerController
            dateTimePicker.callback1 = {self.departuteTime.setTitle($0, for: .normal)}
        }
        else if segue.identifier == "PickAlarmTime"{
            self.title = ""
            let dateTimePicker = segue.destination as! ScheduleRepetController
           // dateTimePicker.callbackAlarmTime1 = {self.alarmTime.setTitle($0, for: .normal)}
        }

    }

    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goBackToDetailController", sender: nil)
        
    }
    

}
