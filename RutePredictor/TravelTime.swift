//
//  File.swift
//  RutePredictor
//
//  Created by Lingeswaran Kandasamy on 8/3/17.
//  Copyright © 2017 Lingeswaran Kandasamy. All rights reserved.
//

//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Caleb Stultz on 7/27/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import UIKit
import Alamofire

class TravelTime {
       var _estimateArrivalTime: String!
    
        var estimateArrivalTime: String {
            if _estimateArrivalTime == nil {
                _estimateArrivalTime = ""
            }
                return _estimateArrivalTime
        }
    
    }
