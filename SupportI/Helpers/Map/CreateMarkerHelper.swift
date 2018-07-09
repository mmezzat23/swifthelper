import MapKit
/** my custom helpers **/
extension MapHelper{
    
    func dropPinZoomIn(_ placemark: MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView?.removeAnnotations((mapView?.annotations)!)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        //annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        mapView?.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView?.setRegion(region, animated: true)
        
        self.address(lat: annotation.coordinate.latitude, lng: annotation.coordinate.longitude)
        self.delegate?.searchCallBack(lat: annotation.coordinate.latitude, lng: annotation.coordinate.longitude)
    }
    
    func dropPinZoomIn(_ annotation:CustomAnnotation<Any>?){
        guard let marker = annotation else{return}
        var center = CLLocationCoordinate2D(latitude: 30, longitude: 31)
        if let lat = marker.lat{
            center.latitude = lat
        }
        if let lng = marker.lng{
            center.longitude = lng
        }
        // clear existing pins
        if mapView != nil{
            mapView!.removeAnnotations((mapView?.annotations)!)
        }
        
        marker.coordinate = center
        mapView!.addAnnotation(marker)
        let span = MKCoordinateSpanMake(0.010, 0.010)
        let region = MKCoordinateRegionMake(marker.coordinate, span)
        self.mapView?.setRegion(region, animated: true)
        
    }
    func dropPinZoomIn(_ location:CLLocationCoordinate2D?){
        if location != nil{
            // clear existing pins
            mapView?.removeAnnotations((mapView?.annotations)!)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location!
            
            
            mapView?.addAnnotation(annotation)
            let span = MKCoordinateSpanMake(0.010, 0.010)
            let region = MKCoordinateRegionMake(annotation.coordinate, span)
            self.mapView?.setRegion(region, animated: true)
        }
        
    }
    func dropPinZoomIn( lat:Double , lng:Double){
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        // clear existing pins
        mapView?.removeAnnotations((mapView?.annotations)!)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        
        
        mapView?.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.010, 0.010)
        let region = MKCoordinateRegionMake(annotation.coordinate, span)
        self.mapView?.setRegion(region, animated: true)
        
    }
}
