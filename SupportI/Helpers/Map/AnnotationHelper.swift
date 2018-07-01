import MapKit

extension MapHelper{
    func createCustomAnnotation(_ id:Any = "",_ image:String = "",_ lat:Double = 0 , _ lng:Double = 0 , placeHolder:UIImage? = nil,model:Any? = nil) -> CustomAnnotation<Any> {
        let annotation = CustomAnnotation<Any>()
        annotation.id = id
        annotation.image = image
        annotation.lat = lat
        annotation.lng = lng
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
        annotation.placeHolder = placeHolder
        annotation.model = model
        
        return annotation
    }
    public func setAnnotations(){
        guard let annotations = self.delegate?.customAnnotation() else{return}
        if self.mapView != nil{
            mapView?.removeAnnotations((mapView?.annotations)!)
            self.mapView?.addAnnotations(annotations)
        }
    }
 
    func defaultAnnotation(annotation:MKAnnotation,mapView:MKMapView!)->MKPinAnnotationView?{
        let reuseId = "pin"
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        guard let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView else { return nil }
        
        pinView.pinTintColor = Constants.mainColorRGB
        pinView.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        var button: UIButton?
        button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button?.setBackgroundImage(UIImage(named: "car"), for: UIControlState())
        button?.addTarget(self, action: #selector(self.getDirections), for: .touchUpInside)
        pinView.leftCalloutAccessoryView = button
        
        return pinView
        
    }
 
    func customAnnotation(annotation:MKAnnotation,mapView:MKMapView!)->MKAnnotationView?{
        
        
        let reuseId = "maker_map \(random())"
        
        if !(annotation is CustomAnnotation<Any>) {
            return nil
        }
        
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = AnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = false
            
        }
        else {
            anView?.annotation = annotation
        }
        let marker = annotation as! CustomAnnotation<Any>
        
        if marker.placeHolder != nil{
            anView?.image = marker.placeHolder
        }else{
            let outerView = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            let myImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            myImage.clipsToBounds = true
            myImage.layer.cornerRadius = 25
            myImage.border(width: 2, color: UIColor.white)
            
            
            myImage.setImage(url:  marker.image)
            
            myImage.addSubview(outerView)
            anView?.addSubview(myImage)
            
            anView?.width = 50
            anView?.height = 50
            anView?.shadow(radius: 8, height: 0, opacity: 0.7, color: UIColor(red: 122/255, green: 72/255, blue: 145/255, alpha: 0.50))
            
            
            
        }
      
        return anView
    }
    
    @objc func getDirections(){
        guard let selectedPin = selectedPin else { return }
        let mapItem = MKMapItem(placemark: selectedPin)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
 
    
}


/** upper custom View **/
extension MapHelper{
   
    func initCustomView(_ view:MKAnnotationView , _ marker:CustomAnnotation<Any>){
        //check upperview of marker from delegate
        let upperView = self.delegate?.upperViewMarker(marker: marker) as? CustomView
        if let _ = upperView{
            // customaization of view
            //upperView?.button?.addTarget(self, action: #selector(upperViewAction(sender:)), for: .touchUpInside)
            
            let button = UIButton(frame: upperView!.frame)
            button.addTarget(self, action: #selector(MapHelper.upperViewAction(sender:)), for: .touchUpInside)
            upperView?.addSubview(button)
            
            upperView?.center = CGPoint(x: view.bounds.size.width / 2, y: -upperView!.bounds.size.height*0.52)
            view.addSubview(upperView!)
            self.mapView?.setCenter((view.annotation?.coordinate)!, animated: true)
            
        }
    }
}



