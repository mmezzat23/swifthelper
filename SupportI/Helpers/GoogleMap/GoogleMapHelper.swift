//
//  MapHelper.swift
//  homeCheif
//
//  Created by mohamed abdo on 4/8/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class GoogleMapHelper: NSObject, MapRouteHelper, MapAddressHelper, MapPlaceHelper {
    /* mapview */
    private var _mapView: GMSMapView!
    private let marker = GMSMarker()

    /* delegates */
    private weak var _delegate: GoogleMapHelperDelegate?
    private weak var _markerDataSource: MarkerDataSource?
    /* AR*/
    private var moveMent: ARCarMovement?
    internal let geocoder = GMSGeocoder()

    /** options **/
    var useNearestPlaces: Bool = false
    var useRoad: Bool = true
    var useMarkerDataSoruce: Bool = true
    var useARMovement: Bool = true
    var zoom: Zoom = .streets
    /** options **/

    var mapView: GMSMapView? {
        get {
            return _mapView
        }
        set {
            _mapView = newValue
            _mapView.delegate = self
        }
    }
    var delegate: GoogleMapHelperDelegate? {
        get {
            return _delegate
        } set {
            _delegate = newValue
        }
    }
    var markerDataSource: MarkerDataSource? {
        get {
            return _markerDataSource
        } set {
            _markerDataSource = newValue
        }
    }
    override init() {
        super.init()
        if useARMovement {
            self.moveMent = ARCarMovement()
            self.moveMent?.delegate = self
        }
    }

    public func reload() {
    }
}

extension GoogleMapHelper: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        self.delegate?.didTapOnMyLocation(lat: location.latitude, lng: location.longitude)
    }
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        self.delegate?.didTapOnMyLocation()
        return true
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.delegate?.didTapOnMarker(marker: marker)
        return true
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("cliecked on map")
        self.delegate?.didTapOnMap(lat: coordinate.latitude, lng: coordinate.longitude)
    }
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        mapView.clear()
        geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
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
                self.delegate?.didChangeCameraLocation(lat: result.coordinate.latitude, lng: result.coordinate.longitude)
                self.addressDelegate?.didGetAddress(name: title)
                self.addressDelegate?.didGetAddress(snippet: snippet)
                /** call **/
            }
        }
    }
    public func updateCamera(lat: Double, lng: Double) {
        self.mapView?.clear()
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: self.zoom.rawValue)
        self.mapView?.camera = camera
        self.mapView?.animate(to: camera)
    }
    public func setMarker(position: CLLocationCoordinate2D!, title: String? = nil, snippet: String? = nil) {
        let attr = self.markerDataSource?.marker()
        marker.position = position
        marker.title = title
        marker.snippet = snippet
        if let options = attr {
            if options.use == .icon {
                marker.icon = options.icon
            } else if options.use == .image {
                marker.iconView = options.image
            } else {
                let view = UIImageView()
                view.tintColor = options.color
                marker.iconView = view
            }
        }
        marker.icon = #imageLiteral(resourceName: "Slider")
        marker.map = mapView
    }
}

extension GoogleMapHelper: MarkerDelegate {
    public func setMarker(marker: GMSMarker!) {
        marker.map = mapView
    }
    public func removeMarker(marker: GMSMarker) {
        marker.map = nil
    }
    func refresh(lat: Double! = nil, lng: Double! = nil) {
        self.mapView?.clear()
        guard let markers = self.markerDataSource?.setMarkers() else { return }
        markers.forEach { (marker) in
            if marker.map != nil {
                marker.map = nil
            }
            self.setMarker(marker: marker)
        }
        if lat != nil && lng != nil {
            self.setMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        }
    }
    func refreshARMovement(lat: Double! = nil, lng: Double! = nil) {
        self.mapView?.clear()
        guard let markers = self.markerDataSource?.setMarkers() else { return }
        markers.forEach { (marker) in
            if marker.oldPosition == nil {
                marker.oldPosition = marker.position
            }
            self.moveMent?.arCarMovement(marker, withOldCoordinate: marker.oldPosition!,
                                         andNewCoordinate: marker.position, inMapview: self.mapView, withBearing: 0)
        }
        if lat != nil && lng != nil {
            self.setMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        }
    }
    func refreshARMovement(marker: GMSMarker) {
        if marker.oldPosition == nil {
            marker.oldPosition = marker.position
        }
        self.moveMent?.arCarMovement(marker, withOldCoordinate: marker.oldPosition!, andNewCoordinate: marker.position, inMapview: nil, withBearing: 0)
    }
}
/** AR **/
extension GoogleMapHelper: ARCarMovementDelegate {
    func arCarMovement(_ movedMarker: GMSMarker?) {
    }
}
