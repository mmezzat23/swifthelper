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

private var polylineFile: GMSPolyline! = GMSPolyline()
private var oldOrginFile: CLLocation?
private var oldDestinationFile: CLLocation?
private var polylineAttrFile: PolylineDataSource?

protocol MapRouteHelper: class {
    var oldOrgin: CLLocation? { get set }
    var oldDestination: CLLocation? { get set }
    var polyline: GMSPolyline! { get set }
    var polylineDataSource: PolylineDataSource? { get set }
    func routeAPI(orgin: CLLocation, destination: CLLocation)
    func drawRoute(orgin: CLLocation, destination: CLLocation)
}

extension MapRouteHelper where Self: GoogleMapHelper {
    var oldOrgin: CLLocation? {
        set {
            oldOrginFile = newValue
        } get {
            return oldOrginFile
        }
    }
    var oldDestination: CLLocation? {
        set {
            oldDestinationFile = newValue
        } get {
            return oldDestinationFile
        }
    }
    var polyline: GMSPolyline! {
        set {
            polylineFile = newValue
        } get {
            return polylineFile
        }
    }
    weak var polylineDataSource: PolylineDataSource? {
        set {
            polylineAttrFile = newValue
        } get {
            return polylineAttrFile
        }
    }
    func drawRoute(orgin: CLLocation, destination: CLLocation) {
        if destination.coordinate.latitude != 0 && destination.coordinate.longitude != 0 && orgin.coordinate.latitude != 0 && orgin.coordinate.longitude != 0 {
            if self.oldOrgin?.coordinate.latitude == orgin.coordinate.latitude
                && self.oldOrgin?.coordinate.longitude == orgin.coordinate.longitude
                && self.oldDestination?.coordinate.latitude == destination.coordinate.latitude
                && self.oldDestination?.coordinate.longitude == destination.coordinate.longitude
                && self.polyline != nil {
                if self.polyline.map == nil {
                    self.polyline.map = self.mapView
                }
            } else {
                self.oldOrgin = orgin
                self.oldDestination = destination
                self.routeAPI(orgin: orgin, destination: destination)
                self.polyline.map = self.mapView

            }
        }
    }
    func routeAPI(orgin: CLLocation, destination: CLLocation) {
        let originLoc = "\(orgin.coordinate.latitude),\(orgin.coordinate.longitude)"
        let destinationLoc = "\(destination.coordinate.latitude),\(destination.coordinate.longitude)"
        var url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(originLoc)&destination=\(destinationLoc)&mode=driving&key="
        url = "\(url)\(Constants.googleRoutesAPI)"
        Alamofire.request(url).responseJSON { response in
            do {
                let route = try JSONDecoder().decode(MapPath.self, from: response.data!)
                if let points = route.routes?.first?.overview_polyline?.points {
                   self.drawPoly(points: points)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func drawPoly(points: String) {
        let polyAttr = self.polylineDataSource?.polyline()
        let path = GMSPath(fromEncodedPath: points)
        self.polyline.path = path
        if polyAttr == nil {
            self.polyline.strokeWidth = 3.0
            self.polyline.strokeColor = .red
        } else {
            self.polyline.strokeWidth = polyAttr!.width
            self.polyline.strokeColor = polyAttr!.color
        }
//        if self.polyline != nil {
//            self.polyline.map = nil
//        }
    }

}
