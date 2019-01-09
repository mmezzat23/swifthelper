//
//  MapProtocolHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//
import CoreLocation
import GoogleMaps


protocol MapAddressHelper:class {
    func address(lat:Double , lng:Double)
    func address(degree:CLLocationCoordinate2D)
    func address(location:CLLocation)
}

extension MapAddressHelper where Self:GoogleMapHelper {
    
    func address(lat:Double , lng:Double){
        let degree = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        geocoder.reverseGeocodeCoordinate(degree) { (response, error) in
            guard error == nil else {
                return
            }
            if let result = response?.firstResult() {
                /** set Marker **/
                var lines:[String] = []
                var title = ""
                var snippet = ""
                if let _ = result.lines {
                    lines.append(contentsOf: result.lines!)
                }
                title = lines.first!
                snippet = title
                if lines.isset(1) {
                    snippet = lines[1]
                }
                /** call delegate **/
                self.delegate?.locationCallback(name: title)
                self.delegate?.locationCallback(address: snippet)
                /** call **/
            }
        }
    }
    func address(degree:CLLocationCoordinate2D){
        geocoder.reverseGeocodeCoordinate(degree) { (response, error) in
            guard error == nil else {
                return
            }
            if let result = response?.firstResult() {
                /** set Marker **/
                var lines:[String] = []
                var title = ""
                var snippet = ""
                if let _ = result.lines {
                    lines.append(contentsOf: result.lines!)
                }
                title = lines.first!
                snippet = title
                if lines.isset(1) {
                    snippet = lines[1]
                }
                /** call delegate **/
                self.delegate?.locationCallback(name: title)
                self.delegate?.locationCallback(address: snippet)
                /** call **/
                
            }
        }
    }
    func address(location:CLLocation){
        geocoder.reverseGeocodeCoordinate(location.coordinate) { (response, error) in
            guard error == nil else {
                return
            }
            if let result = response?.firstResult() {
                /** set Marker **/
                var lines:[String] = []
                var title = ""
                var snippet = ""
                if let _ = result.lines {
                    lines.append(contentsOf: result.lines!)
                }
                title = lines.first!
                snippet = title
                if lines.isset(1) {
                    snippet = lines[1]
                }
                /** call delegate **/
                self.delegate?.locationCallback(name: title)
                self.delegate?.locationCallback(address: snippet)
                /** call **/
                
            }
        }
    }

}
