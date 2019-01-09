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

class GoogleMapHelper:NSObject,MapRouteHelper,MapSearchHelper,MapAddressHelper,MapPlaceHelper{
  
    /* mapview */
    private var _mapView:GMSMapView!

    /* currentLocation */
    var location:CLLocation?
    var degree:CLLocationCoordinate2D?{
        get{
            return location?.coordinate
        }
    }
    var lat:Double?{
        get{
            return location?.coordinate.latitude
        }
    }
    var lng:Double?{
        get{
            return location?.coordinate.longitude
        }
    }
    
    /* delegates */
    private weak var _delegate:GoogleMapHelperDelegate?
    weak var markerDataSource:MarkerDataSource?
    
    /* AR*/
    var moveMent:ARCarMovement?

    var locationManager:CLLocationManager!
    let geocoder = GMSGeocoder()

    /** options **/
    var updated:Bool = false
    var setMarkerOnChangeCamera:Bool = false
    var changedCamera:Bool = false
    var useNearestPlaces:Bool = false
    var useRoad:Bool = true
    var useSearch:Bool = true
    var useMarkerDataSoruce:Bool = true
    var useARMovement:Bool = true
    var changeCameraOnMarker:Bool = false
    var zoom:Zoom = .streets
    /** options **/
    

    /** places **/
    var placesClient: GMSPlacesClient!
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    

    var mapView:GMSMapView? {
        get{
            return _mapView
        }
        set{
            _mapView = newValue
            _mapView.delegate = self
        }
    }
    
    weak var delegate:GoogleMapHelperDelegate?{
        get{
            return _delegate
        }
        set{
            _delegate = newValue
        }
    }
    
    
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        if useARMovement {
            self.moveMent = ARCarMovement()
            self.moveMent?.delegate = self
        }
    }
    
    public func reload(){
        self.updated = false
        self.currentLocation()
    }
    
}

extension GoogleMapHelper:GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        if  !changedCamera {
            mapView.clear()
            geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
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
                        self.setMarker(position: cameraPosition.target,title: title , snippet: snippet)
                    }else{
                        self.setMarker(position: cameraPosition.target,title: title , snippet: "")
                    }
                    /** call delegate **/
                    self.delegate?.locationCallback(name: title)
                    self.delegate?.locationCallback(address: snippet)
                    self.delegate?.locationCallback(lat: result.coordinate.latitude, lng: result.coordinate.longitude)
                    /** call **/
                    if !self.setMarkerOnChangeCamera {
                        self.changedCamera = true
                    }else{
                        self.changedCamera = false
                    }
                }
            }
        }
        
    }
  
    
}
/** part of location **/
extension GoogleMapHelper:CLLocationManagerDelegate{
    
    public func updateCamera(lat:Double , lng:Double){
        self.changedCamera = false
        self.mapView?.clear()
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: self.zoom.rawValue)
        self.mapView?.camera = camera
        self.mapView?.animate(to: camera)
    }
    public func updateCameraWithOutMarker(lat:Double , lng:Double){
        self.changedCamera = true
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: self.zoom.rawValue)
        self.mapView?.camera = camera
        self.mapView?.animate(to: camera)
    }
    public func setMarker(position:CLLocationCoordinate2D! , title:String? = nil , snippet:String? = nil){
        let attr = self.markerDataSource?.marker()
        let marker = GMSMarker()
        marker.position = position
        marker.title = title
        marker.snippet = snippet
        
        if let options = attr {
            if options.use == .icon {
                marker.icon = options.icon
            }else if options.use == .image {
                marker.iconView = options.image
            }else {
                let view = UIImageView()
                view.tintColor = options.color
                marker.iconView = view
            }
        }
        
        marker.map = mapView
        
        if changeCameraOnMarker{
            let camera = GMSCameraPosition.camera(withLatitude: position.latitude, longitude: position.longitude, zoom: self.zoom.rawValue)
            self.mapView?.camera = camera
            self.mapView?.animate(to: camera)
        }
        
    }
    public func currentLocation(){
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            locationManager.delegate = self

            placesClient = GMSPlacesClient.shared()

        }else{
            let topViewController = UIApplication.topMostController()
            topViewController.showAlert(title: translate("location_error"), message: translate("you_are_not_allow_use_your_location"))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation // note that locations is same as the one in the function declaration
        if !updated {
            manager.stopUpdatingLocation()
            locationManager.stopUpdatingLocation()
            /** set current location */
            self.location = userLocation
            
            if(self.mapView != nil){
                self.mapView?.clear()
                let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, zoom: self.zoom.rawValue)
                self.mapView?.camera = camera
                self.mapView?.animate(to: camera)
                
                
            }
            updated = true
        }
        
    }
    
}

extension GoogleMapHelper:MarkerDelegate{
    public func setMarker(marker:GMSMarker!){
        marker.map = mapView
    }
    public func removeMarker(marker:GMSMarker){
        marker.map = nil
    }
    func refresh(lat:Double! = nil , lng:Double! = nil) {
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
    func refreshARMovement(lat:Double! = nil , lng:Double! = nil) {
        self.mapView?.clear()
        guard let markers = self.markerDataSource?.setMarkers() else { return }
        markers.forEach { (marker) in
            if marker.oldPosition == nil {
                marker.oldPosition = marker.position
            }
            self.moveMent?.arCarMovement(marker, withOldCoordinate: marker.oldPosition!, andNewCoordinate: marker.position, inMapview: self.mapView, withBearing: 0)
        }
        if lat != nil && lng != nil {
            self.setMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        }
    }
    func refreshARMovement(marker:GMSMarker) {
        if marker.oldPosition == nil {
            marker.oldPosition = marker.position
        }
        self.moveMent?.arCarMovement(marker, withOldCoordinate: marker.oldPosition!, andNewCoordinate: marker.position, inMapview: nil, withBearing: 0)
    }
    
}


/** AR **/
extension GoogleMapHelper:ARCarMovementDelegate {
    func arCarMovement(_ movedMarker: GMSMarker?) {
        
    }
}
