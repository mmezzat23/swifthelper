//
//  MapProtocolHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//
import MapKit

public struct MapPath: Decodable {
    var routes: [Route]?
}

public struct Route: Decodable {
    var overview_polyline: OverView?
}

public struct OverView: Decodable {
    var points: String?
}
