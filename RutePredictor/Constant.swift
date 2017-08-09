//
//  Constant.swift
//  iConnectFinal
//
//  Created by Lingeswaran Kandasamy on 5/28/17.
//  Copyright © 2017 Lingeswaran Kandasamy. All rights reserved.
//

import UIKit

let SHADOW_GRAY: CGFloat = 120.0 / 255.0
let KEY_UID = "uid"
import Foundation


typealias DownloadComplete = () -> ()


let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Locations.sharedInstance.latitude!)&lon=\(Locations.sharedInstance.longitude!)&appid=8c0e04b52e6da9e67c51a102d6269a60"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Locations.sharedInstance.latitude!)&lon=\(Locations.sharedInstance.longitude!)&cnt=10&mode=json&appid=42a1771a0b787bf12e734ada0cfc80cb"



let GOOGLE_DISTANCEMATRICS_URL = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=\(Locations.sharedInstance.currentAddress!)&destinations=\(Locations.sharedInstance.destinationAddressURL!)&key=AIzaSyDQXr2TF-uOtfrcUD7QYcuFEcO6fGjNUmE"
