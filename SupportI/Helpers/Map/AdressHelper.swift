import MapKit

/** Address Helper **/
extension MapHelper{
    
    func address(lat:Double?, lng:Double?){
        var lati = 0.0
        var long = 0.0
        if lat != nil{
            lati = lat!
        }
        if lng != nil{
            long = lng!
        }
        let location = CLLocation(latitude: lati, longitude: long)
        self.getAdress(location: location)
    }
    
    
    func parseAddress(_ selectedItem:MKPlacemark) -> String {
        
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil &&
            selectedItem.thoroughfare != nil) ? " " : ""
        
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
            (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
            selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        
        return addressLine
    }
    func getAdress(location:CLLocation){
        
        
        if #available(iOS 11.0, *) {
            CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale(identifier: Constants.locale)) { (placemark, error) in
                if error != nil {
                    
                } else {
                    
                    let place = placemark! as [CLPlacemark]
                    
                    if place.count > 0 {
                        let place = placemark![0]
                        
                        var adressString : String = ""
                        
                        if place.thoroughfare != nil {
                            adressString = adressString + place.thoroughfare! + ", "
                        }
                        if place.subThoroughfare != nil {
                            adressString = adressString + place.subThoroughfare! + "\n"
                        }
                        if place.locality != nil {
                            adressString = adressString + place.locality! + " - "
                        }
                        if place.postalCode != nil {
                            adressString = adressString + place.postalCode! + "\n"
                        }
                        if place.subAdministrativeArea != nil {
                            adressString = adressString + place.subAdministrativeArea! + " - "
                        }
                        if place.country != nil {
                            adressString = adressString + place.country!
                        }
                        
                        self.delegate?.addressCallBack(address: adressString)
                        
                    }
                    
                }
            }
        }else{
            CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
                if error != nil {
                    
                } else {
                    
                    let place = placemark! as [CLPlacemark]
                    
                    if place.count > 0 {
                        let place = placemark![0]
                        
                        var adressString : String = ""
                        
                        if place.thoroughfare != nil {
                            adressString = adressString + place.thoroughfare! + ", "
                        }
                        if place.subThoroughfare != nil {
                            adressString = adressString + place.subThoroughfare! + "\n"
                        }
                        if place.locality != nil {
                            adressString = adressString + place.locality! + " - "
                        }
                        if place.postalCode != nil {
                            adressString = adressString + place.postalCode! + "\n"
                        }
                        if place.subAdministrativeArea != nil {
                            adressString = adressString + place.subAdministrativeArea! + " - "
                        }
                        if place.country != nil {
                            adressString = adressString + place.country!
                        }
                        
                        self.delegate?.addressCallBack(address: adressString)
                        
                    }
                    
                }
            }
        }
    }
    
    
}
