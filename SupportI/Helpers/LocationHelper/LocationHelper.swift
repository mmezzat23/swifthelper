//
//  LocationHelper.swift
//  SupportI
//
//  Created by mohamed abdo on 9/2/19.
//  Copyright © 2019 MohamedAbdu. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationDelegate: class {
    func didUpdateLocation(lat: Double, lng: Double)
}
extension MapAddressDelegate {
    func didUpdateLocation(lat: Double, lng: Double) {
        
    }

}
class LocationHelper: NSObject {
    private var locationManager: CLLocationManager!
    var locationUpdated: Bool = false

    private var _delegate: LocationDelegate?
    weak var delegate: LocationDelegate? {
        set {
            _delegate = newValue
        } get {
            return _delegate
        }
    }
    /* currentLocation */
    var location: CLLocation?
    var degree: CLLocationCoordinate2D? {
        get {
            return location?.coordinate
        }
    }
    var lat: Double? {
        get{
            return location?.coordinate.latitude
        }
    }
    var lng: Double? {
        get{
            return location?.coordinate.longitude
        }
    }
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
    }
    
    public func reload() {
        self.locationUpdated = false
        self.currentLocation()
    }
    
}

/** part of location **/
extension LocationHelper: CLLocationManagerDelegate {
    
    public func currentLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
            
        } else {
            let topViewController = UIApplication.topMostController()
            topViewController.showAlert(title: translate("location_error"), message: translate("you_are_not_allow_use_your_location"))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation // note that locations is same as the one in the function declaration
        if !locationUpdated {
            manager.stopUpdatingLocation()
            locationManager.stopUpdatingLocation()
            /** set current location */
            self.location = userLocation
            self.delegate?.didUpdateLocation(lat: self.lat ?? 0, lng: self.lng ?? 0)
            locationUpdated = true
        }
        
    }
    
}
