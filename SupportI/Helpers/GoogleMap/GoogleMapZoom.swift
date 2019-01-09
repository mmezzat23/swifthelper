//
//  MapProtocolHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//
import CoreLocation
import GoogleMaps
import GooglePlaces

extension GoogleMapHelper {
    enum Zoom:Float {
        case world = 1
        case landmass = 5
        case city = 10
        case streets = 15
        case buildings = 20
    }
}
