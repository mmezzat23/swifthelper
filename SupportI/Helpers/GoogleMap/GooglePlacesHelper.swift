//
//  GooglePlaces.swift
//  Dana
//
//  Created by mohamed abdo on 9/21/18.
//  Copyright © 2018 Dana. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

protocol PlacesPickerDelegate: class {
    func didPickPlace(place: PlacePickerModel.PlacePickerResult)
}

fileprivate weak var placePickerPrivate: PlacesPickerDelegate?

protocol MapPlaceHelper: class {
    var placePickerDelegate: PlacesPickerDelegate? { get set }
    func placePicker()
}

extension MapPlaceHelper where Self: GoogleMapHelper {
    var placePickerDelegate: PlacesPickerDelegate? {
        set {
            placePickerPrivate = newValue
        } get {
            return placePickerPrivate
        }
    }
    func placePicker() {
        if self.placePickerDelegate is UIViewController {
            let delegate = self.placePickerDelegate as? UIViewController
            let storyboard = UIStoryboard(name: "PlacesPickerHelper", bundle: nil)
            guard let navVC = storyboard.instantiateInitialViewController() as? UINavigationController else { return }
            let pickerVC = navVC.topViewController as? PlacePickerController
            pickerVC?.delegate = self.placePickerDelegate
            delegate?.present(navVC, animated: true, completion: nil)
            //delegate?.present(pickerVC, animated: false, completion: nil)
        }
    }
}

// To receive the results from the place picker 'self' will need to conform to
// GMSPlacePickerViewControllerDelegate and implement this code.
