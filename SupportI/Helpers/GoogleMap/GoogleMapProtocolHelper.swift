//
//  MapProtocolHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//
import MapKit

protocol GoogleMapHelperDelegate: class {
    func didChangeCameraLocation(lat: Double, lng: Double)
    func didClickOnMap(lat: Double, lng: Double)
   
}
extension GoogleMapHelperDelegate where Self: Any {
    func didChangeCameraLocation(lat: Double, lng: Double) {
        
    }
    func didClickOnMap(lat: Double, lng: Double) {
        
    }
}
