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

enum MarkerUse {
    case color
    case icon
    case image
}
struct MarkerAttrbuite {
    var color: UIColor?
    var icon: UIImage?
    var image: UIImageView?
    var use: MarkerUse!
}
private var markersFile: [GMSMarker: CLLocationCoordinate2D] = [:]
extension GMSMarker {
    var oldPosition: CLLocationCoordinate2D? {
        set {
            markersFile[self] = newValue
        } get {
            if markersFile[self] != nil {
                return markersFile[self]
            } else {
                return nil
            }
        }
    }
}
