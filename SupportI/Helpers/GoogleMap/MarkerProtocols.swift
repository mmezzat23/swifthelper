//
//  MapProtocolHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//
import Alamofire
import CoreLocation
import GoogleMaps
import GooglePlaces

protocol MarkerDataSource:class {
    func marker() -> MarkerAttrbuite
    func setMarkers()->[GMSMarker]
}
extension MarkerDataSource {
    func setMarkers()->[GMSMarker]{
        return []
    }
}
protocol MarkerDelegate:class {
    func refresh()
    func refreshARMovement()
}
extension MarkerDelegate {
    func refresh(){
        
    }
    func refreshARMovement(){
        
    }
}
