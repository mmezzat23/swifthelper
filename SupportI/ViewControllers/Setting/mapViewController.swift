//
//  mapViewController.swift
//  SupportI
//
//  Created by Kareem on 9/26/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlacesSearchController

protocol SelectLocationDelegate: class {
    func didSelectLocation(lat: Double, lng: Double)
    func didSelectLocation(address: String?)
}
class mapViewController: BaseController {
    var location: LocationHelper?
    var google: GoogleMapHelper?
    var lat: Double?
    var lng: Double?
    @IBOutlet weak var edit: UITextField!
    @IBOutlet weak var discard: UIButton!
    @IBOutlet weak var yes: UIButton!
    
    weak var delegate: SelectLocationDelegate?
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        
        if (UserRoot.saller() == true){
            yes.backgroundColor = UIColor(red: 01, green: 14, blue: 47)
            discard.borderColor = UIColor(red: 01, green: 14, blue: 47)
            discard.setTitleColor( UIColor(red: 01, green: 14, blue: 47)
, for: .normal) 
        }
        // Do any additional setup after loading the view.
    }
    func setup() {
        google = .init()
        google?.mapView = mapView
        google?.delegate = self
        location = .init()
        location?.onUpdateLocation = { degree in
            self.google?.updateCamera(lat: degree?.latitude ?? 0, lng: degree?.longitude ?? 0)
        }
        location?.currentLocation()
        edit.UIViewAction {
            let controller = GooglePlacesSearchController(delegate: self,
                                                          apiKey: Constants.googleNotRestrictionKey,
                                                          placeType: .address)
            self.present(controller, animated: true, completion: nil)
        }
    }
    @IBAction func yesClicked(_ sender: UIButton) {
        self.delegate?.didSelectLocation(lat: lat ?? 0, lng: lng ?? 0)
        self.google?.address(lat: lat ?? 0, lng: lng ?? 0, handler: { title, snippet in
            self.delegate?.didSelectLocation(address: title)
            self.dismiss(animated: true, completion: nil)

        })
    }
    
    @IBAction func discardClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension mapViewController: GoogleMapHelperDelegate {
    func didChangeCameraLocation(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
        google?.setMarker(position: CLLocationCoordinate2D(latitude: self.lat ?? 0, longitude: self.lng ?? 0))
    }
    func didTapOnMap(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
        google?.setMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        
    }
}
extension mapViewController: GooglePlacesAutocompleteViewControllerDelegate {
    func viewController(didAutocompleteWith place: PlaceDetails) {
//        self.addressLbl.text = place.formattedAddress
        self.lat = place.coordinate!.latitude
        self.lng = place.coordinate!.longitude
        google?.setMarker(position: CLLocationCoordinate2D(latitude: self.lat ?? 0, longitude: self.lng ?? 0))

        dismiss(animated: true, completion: nil)
        
    }
}
