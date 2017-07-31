//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Caleb Stultz on 7/28/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import CoreLocation

class Locations {
    static var sharedInstance = Locations()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
