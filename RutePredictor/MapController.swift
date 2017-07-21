//
//  MapController.swift
//  RutePredictor
//
//  Created by Lingeswaran Kandasamy on 7/18/17.
//  Copyright © 2017 Lingeswaran Kandasamy. All rights reserved.
//

import UIKit
import GoogleMaps



class MapController: UIViewController, CLLocationManagerDelegate{
    
    var locationManager = CLLocationManager()
    let marker = GMSMarker()
    var mapView: GMSMapView!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        GMSServices.provideAPIKey("AIzaSyCKCgrxyuPLaRfsMklVgu7zGpdTDjzCvx4")
        locationManager.startUpdatingLocation()
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.621262, longitude: -122.378945, zoom:15)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
       }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if (status == CLAuthorizationStatus.authorizedWhenInUse)
        {
            mapView.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let newLocation = locations.last
        mapView.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 17.0)
        mapView.settings.myLocationButton = true
        self.view = self.mapView
        
        marker.position = CLLocationCoordinate2DMake(newLocation!.coordinate.latitude, newLocation!.coordinate.longitude)
        marker.map = self.mapView
        
        
                let geoCoder = CLGeocoder()
                geoCoder.reverseGeocodeLocation(newLocation!, completionHandler: { (placemarks, error) -> Void in
                    if placemarks != nil{
                    let placeMark = placemarks![0]
        
                    if let locationCity = placeMark.addressDictionary!["City"] as? NSString {
                        self.marker.title = locationCity as String
                    }
        
                    if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                        self.marker.snippet = locationName as String
                    }
                    }
                })
    }
    
    
}

