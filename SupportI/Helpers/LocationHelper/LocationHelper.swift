//
//  LocationHelper.swift
//  SupportI
//
//  Created by mohamed abdo on 9/2/19.
//  Copyright © 2019 MohamedAbdu. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

typealias OnUpdateLocation = ((CLLocationCoordinate2D?) -> Void)

protocol LocationDelegate: class {
    func didUpdateLocation(lat: Double, lng: Double)
}
extension LocationDelegate {
    func didUpdateLocation(lat: Double, lng: Double) {
    }

}
class LocationHelper: NSObject {
    private var locationManager: CLLocationManager!
    private var locationUpdated: Bool = false

    var useInBackground: Bool = false
    var updateLocationInDistance: Double?
    var useOnlyoneTime: Bool = true
    private weak var _delegate: LocationDelegate?
    var delegate: LocationDelegate? {
        set {
            _delegate = newValue
        } get {
            return _delegate
        }
    }
    var onUpdateLocation: OnUpdateLocation?
    /* currentLocation */
    var location: CLLocation?
    var degree: CLLocationCoordinate2D? {
        return location?.coordinate
    }
    var lat: Double? {
        return location?.coordinate.latitude
    }
    var lng: Double? {
        return location?.coordinate.longitude
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
            if updateLocationInDistance == nil {
                locationManager.distanceFilter = kCLDistanceFilterNone
            } else {
                locationManager.distanceFilter = updateLocationInDistance ?? 0
            }
            if useInBackground {
                locationManager.allowsBackgroundLocationUpdates = true
                //locationManager.showsBackgroundLocationIndicator = true
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
        } else {
            let topViewController = UIApplication.topMostController()
            topViewController.showAlert(title: "location_error.lan".localized, message: "you_are_not_allow_use_your_location.lan".localized)
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation // note that locations is same as the one in the function declaration
        self.location = userLocation
        self.delegate?.didUpdateLocation(lat: self.lat ?? 0, lng: self.lng ?? 0)
        self.onUpdateLocation?(self.degree)
        if useOnlyoneTime {
            manager.stopUpdatingLocation()
            locationManager.stopUpdatingLocation()
            if !locationUpdated {
                /** set current location */
                locationUpdated = true
            }
        }
    }
}
