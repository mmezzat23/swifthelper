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


protocol MapSearchHelper:class {
   func search()
}

extension MapSearchHelper where Self:GoogleMapHelper {
    
    func search(){
        if self.delegate is UIViewController {
            let vc = self.delegate as! UIViewController
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            vc.present(autocompleteController, animated: true, completion: nil)
        }
        
    }

}

extension GoogleMapHelper:GMSAutocompleteViewControllerDelegate{
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        self.delegate?.locationCallback(name: place.name)
        self.delegate?.locationCallback(address: place.formattedAddress)
        self.delegate?.locationCallback(lat: place.coordinate.latitude, lng: place.coordinate.longitude)
        if self.delegate is UIViewController {
            let vc = self.delegate as! UIViewController
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        if self.delegate is UIViewController {
            let vc = self.delegate as! UIViewController
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
