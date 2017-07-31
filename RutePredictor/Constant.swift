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

//http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b1b15e88fa797225412429c1c50c122a1

let CURRENT_WEATHER_URL = "http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b1b15e88fa797225412429c1c50c122a1"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Locations.sharedInstance.latitude!)&lon=\(Locations.sharedInstance.longitude!)&cnt=10&mode=json&appid=42a1771a0b787bf12e734ada0cfc80cb"


//let GOOGLE_DISTANCEMATRICS_URL = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=Washington,DC&destinations=New+York+City,NY&key=AIzaSyDQXr2TF-uOtfrcUD7QYcuFEcO6fGjNUmE"

