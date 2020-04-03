//
//  MapProtocolHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//
import GoogleMaps
protocol GoogleMapHelperDelegate: class {
    func didChangeCameraLocation(lat: Double, lng: Double)
    func didTapOnMap(lat: Double, lng: Double)
    func didTapOnMarker(marker: GMSMarker)
    func didTapOnMyLocation(lat: Double, lng: Double)
    func didTapOnMyLocation()
}
extension GoogleMapHelperDelegate where Self: Any {
    func didChangeCameraLocation(lat: Double, lng: Double) {
    }
    func didTapOnMap(lat: Double, lng: Double) {
    }
    func didTapOnMarker(marker: GMSMarker) {
    }
    func didTapOnMyLocation(lat: Double, lng: Double) {
    }
    func didTapOnMyLocation() {
    }
}
