//
//  MapProtocolHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//
import CoreLocation
import GoogleMaps

typealias AddressHandler = (String, String) -> Void
protocol MapAddressHelper: class {
    func address(lat: Double, lng: Double, handler: AddressHandler?)
    func address(degree: CLLocationCoordinate2D)
    func address(location: CLLocation)
}
protocol MapAddressDelegate: class {
    func didGetAddress(name: String)
    func didGetAddress(snippet: String)
}
extension MapAddressDelegate {
    func didGetAddress(name: String) {
    }
    func didGetAddress(snippet: String) {
    }
}

fileprivate weak var _delegate: MapAddressDelegate?
extension MapAddressHelper where Self: GoogleMapHelper {
    var addressDelegate: MapAddressDelegate? {
        set {
            _delegate = newValue
        } get {
            return _delegate
        }
    }
    func address(lat: Double, lng: Double, handler: AddressHandler? = nil) {
        let degree = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        geocoder.reverseGeocodeCoordinate(degree) { (response, error) in
            guard error == nil else {
                return
            }
            if let result = response?.firstResult() {
                /** set Marker **/
                var lines: [String] = []
                var title = ""
                var snippet = ""
                if result.lines != nil {
                    lines.append(contentsOf: result.lines!)
                }
                title = lines.first!
                snippet = title
                if lines.isset(1) {
                    snippet = lines[1]
                }
                /** call delegate **/
                handler?(title, snippet)
                print(title)
                self.addressDelegate?.didGetAddress(name: title)
                self.addressDelegate?.didGetAddress(snippet: snippet)
                /** call **/
            }
        }
    }
    func address(degree: CLLocationCoordinate2D) {
        geocoder.reverseGeocodeCoordinate(degree) { (response, error) in
            guard error == nil else {
                return
            }
            if let result = response?.firstResult() {
                /** set Marker **/
                var lines: [String] = []
                var title = ""
                var snippet = ""
                if result.lines != nil {
                    lines.append(contentsOf: result.lines!)
                }
                title = lines.first!
                snippet = title
                if lines.isset(1) {
                    snippet = lines[1]
                }
                /** call delegate **/
                self.addressDelegate?.didGetAddress(name: title)
                self.addressDelegate?.didGetAddress(snippet: snippet)
                /** call **/
            }
        }
    }
    func address(location: CLLocation) {
        geocoder.reverseGeocodeCoordinate(location.coordinate) { (response, error) in
            guard error == nil else {
                return
            }
            if let result = response?.firstResult() {
                /** set Marker **/
                var lines: [String] = []
                var title = ""
                var snippet = ""
                if result.lines != nil {
                    lines.append(contentsOf: result.lines!)
                }
                title = lines.first!
                snippet = title
                if lines.isset(1) {
                    snippet = lines[1]
                }
                /** call delegate **/
                self.addressDelegate?.didGetAddress(name: title)
                self.addressDelegate?.didGetAddress(snippet: snippet)
                /** call **/
            }
        }
    }

}
