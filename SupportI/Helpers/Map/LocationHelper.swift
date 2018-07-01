//
//  LocationHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//

import MapKit
import CoreLocation
/** part of location **/
extension MapHelper:CLLocationManagerDelegate{
    
    public func runDelegates(){
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }else{
            let topViewController = UIApplication.topMostController()
            topViewController.showAlert(title: translate("location_error"), message: translate("you_are_not_allow_use_your_location"))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation // note that locations is same as the one in the function declaration
        manager.stopUpdatingLocation()
        locationManager.stopUpdatingLocation()
        if(!self.updated){
            self.getAdress(location: userLocation)
            self.delegate?.locationCallback(lat: userLocation.coordinate.latitude, lng: userLocation.coordinate.longitude)
        }
        if(self.mapView != nil){
            let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
            self.mapView?.setRegion(region, animated: true)
        }
        
        
    }
}
