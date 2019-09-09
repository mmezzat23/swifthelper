//
//  PlacePickerModel.swift
//  SupportI
//
//  Created by mohamed abdo on 9/3/19.
//  Copyright © 2019 MohamedAbdu. All rights reserved.
//

import Foundation
import GoogleMaps

class PlacePickerModel: Decodable {
    var results: [PlacePickerResult]?
    var status: String?
    
    class PlacePickerResult: Decodable {
        var geometry: PlacePickerGeometry?
        var coordinate: CLLocationCoordinate2D {
            get {
                return CLLocationCoordinate2D(latitude: geometry?.location?.lat ?? 0, longitude: geometry?.location?.lng ?? 0)
            }
        }
        var icon: String?
        var id: String?
        var name: String?
        var place_id: String?
        var reference: String?
        var scope: String?
        var vicinity: String?
    }
    class PlacePickerGeometry: Decodable {
        var location: GeometryLocation?
        
        class GeometryLocation: Decodable {
            var lat: Double?
            var lng: Double?
        }
    }
        
}

