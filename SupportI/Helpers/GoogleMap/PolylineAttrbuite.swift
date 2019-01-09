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


struct PolylineAttrbuite {
    var color:UIColor!
    var width:CGFloat!
}

protocol PolylineDataSource:class {
    func polyline()->PolylineAttrbuite
}
