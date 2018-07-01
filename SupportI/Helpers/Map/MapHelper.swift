//
//  MapHelper.swift
//  homeCheif
//
//  Created by mohamed abdo on 4/8/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapHelper:NSObject{
    /** options **/
    var updated:Bool = false
    var defaultAnnotation:Bool = true
    var clickable:Bool = false
    var selectedPin: MKPlacemark?
    /** options **/
    
    /* delegates */
    private var _mapView:MKMapView!
    private var _locationDelegate:MapHelperDelegate!
    var locationManager:CLLocationManager!
    
    var mapView:MKMapView? {
        get{
            return _mapView
        }
        set{
            _mapView = newValue
            _mapView.delegate = self
            self.configureTileOverlay()
            let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.triggerTouchAction (_:)))
            mapView?.addGestureRecognizer(gesture)
        }
    }
    
    var delegate:MapHelperDelegate?{
        get{
            return _locationDelegate
        }
        set{
            _locationDelegate = newValue!
            runDelegates()
        }
    }
    
    
  
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
    }
    
    @objc func triggerTouchAction(_ gestureReconizer: UITapGestureRecognizer) {
        if clickable{
            let longPressPoint = gestureReconizer.location(in: self.mapView)
            let coordinate  = mapView?.convert(longPressPoint, toCoordinateFrom: self.mapView)
            var lat = 0.0
            var lng = 0.0
            if coordinate != nil{
                lat = Double((coordinate?.latitude)!)
                lng =  Double((coordinate?.longitude)!)
                print(lat,lng)
                mapView?.removeAnnotations((mapView?.annotations)!)
                let marker = createCustomAnnotation("", "", lat, lng)
                self.dropPinZoomIn(marker)
                self.delegate?.locationCallback(lat: lat, lng: lng)
                self.address(lat: lat, lng: lng)
                
            }
            
        }
        
        
    }
    @objc func upperViewAction(sender: UIButton)
    {
        if let superView = sender.superview as? CustomView{
            if superView.customAnnotation != nil{
                self.delegate?.upperViewAction(marker: superView.customAnnotation!)
            }
        }
    }
    
}


/** delegates on mapview **/
extension MapHelper:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        if(self.defaultAnnotation){
            return defaultAnnotation(annotation: annotation, mapView:mapView)
        }else{
            return customAnnotation(annotation: annotation, mapView:mapView)
        }
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.mapView?.deselectAnnotation(view.annotation as? MKPointAnnotation, animated: false)
        guard let annotation = view.annotation else {return}
        
        // if marker type of custom
        if annotation is CustomAnnotation<Any>{
            //create marker
            let marker = annotation as! CustomAnnotation<Any>
            print(marker.id)
            print(marker.image)
            
            self.initCustomView(view,marker)
            //finish recall delegate to selected marker
            self.delegate?.didselectAnnotationCallBack(annotation:marker)
        }
    }
    
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
            for subview in view.subviews
            {
                if subview is CustomView{
                    let customView = subview as! CustomView
                    let marker = customView.customAnnotation
                    if marker != nil{
                        self.mapView?.removeAnnotation(view.annotation!)
                        
                        let markerCp = self.createCustomAnnotation(marker!.id!, marker!.image!, marker!.lat!, marker!.lng!, placeHolder: marker!.placeHolder!, model: marker!.model!)

                        mapView.addAnnotation(markerCp)
                    }
                   
                }
                break
              
            }
        
    }

   
}




/** customs of annotations on map **/
extension MapHelper{
    func search(text:String?) {
        
        guard let mapView = mapView,
            let searchBarText = text else { return  }
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            let items = response.mapItems
            
            self.delegate?.searchCallBack(results: items)
            //let selectedItem = response.mapItems[0].placemark
            //self.dropPinZoomIn(selectedItem)
        }
        
    }
}







