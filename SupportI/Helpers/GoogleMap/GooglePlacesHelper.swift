//
//  GooglePlaces.swift
//  Dana
//
//  Created by mohamed abdo on 9/21/18.
//  Copyright © 2018 Dana. All rights reserved.
//

import Foundation
import CoreLocation
import GooglePlacePicker
import GoogleMaps

//
//class PlacesPickerView: UIViewController, GMSPlacePickerViewControllerDelegate {
//
//    var mapHelper:GoogleMapHelper?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        initView()
//    }
//    func initView(){
//        self.view.backgroundColor = UIColor.white
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        initPlacePicker()
//    }
//    func initPlacePicker(){
//        let center = CLLocationCoordinate2D(latitude: 30.000153, longitude: 31.174317)
//        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001,
//                                               longitude: center.longitude + 0.001)
//        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001,
//                                               longitude: center.longitude - 0.001)
//        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
//        let config = GMSPlacePickerConfig(viewport: viewport)
//        let placePicker = GMSPlacePickerViewController(config: config)
//        placePicker.delegate = self
//        self.present(placePicker, animated: true, completion: nil)
//    }
//
//    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
//        viewController.dismiss(animated: true, completion: {
//            self.dismiss(animated: false, completion: {
//                self.mapHelper?.placePickerDelegate?.didPickPlace(place: place)
//            })
//        })
//    }
//    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
//        viewController.dismiss(animated: true, completion: {
//            self.dismiss(animated: false, completion: nil)
//        })
//    }
//
//}





protocol PlacesPickerDelegate: class {
    func didPickPlace(place: PlacePickerModel.PlacePickerResult)
}

fileprivate weak var placePickerPrivate: PlacesPickerDelegate?


protocol MapPlaceHelper: class {
    var placePickerDelegate: PlacesPickerDelegate? { set get }
    func placePicker()
}

extension MapPlaceHelper where Self:GoogleMapHelper {
    
    weak var placePickerDelegate: PlacesPickerDelegate? {
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
            let pickerVC = navVC.rootViewController as? PlacePickerController
            pickerVC?.delegate = self.placePickerDelegate
            delegate?.present(navVC, animated: true, completion: nil)
            //delegate?.present(pickerVC, animated: false, completion: nil)
        }
    }
    
}

// To receive the results from the place picker 'self' will need to conform to
// GMSPlacePickerViewControllerDelegate and implement this code.


