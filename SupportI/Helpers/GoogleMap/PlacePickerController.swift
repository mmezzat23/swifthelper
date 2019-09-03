//
//  PlacePickerController.swift
//  SupportI
//
//  Created by mohamed abdo on 9/2/19.
//  Copyright © 2019 MohamedAbdu. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
class PlacePickerController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var placesTbl: UITableView! {
        didSet {
            placesTbl.delegate = self
            placesTbl.dataSource = self
        }
    }
    
    var location: LocationHelper?
    var lat: Double = 0
    var lng: Double = 0
    var mapHelper: GoogleMapHelper?
    var delegate: PlacesPickerDelegate?
    /** places **/
    internal var placesClient: GMSPlacesClient!
    // An array to hold the list of likely places.
    internal var likelyPlaces: [PlacePickerModel.PlacePickerResult] = []
    // The currently selected place.
    internal var selectedPlace: PlacePickerModel.PlacePickerResult?
    
    private var isCounterRun: Bool = false
    private lazy var counterLbl: EFCountingLabel = {
     let myLabel = EFCountingLabel(frame: CGRect(x: self.view.width/2 - 20, y: self.placesTbl.y - 50, width: 200, height: 40))
        self.view.addSubview(myLabel)
        myLabel.setUpdateBlock { value, label in
            label.text = Int(value).string
        }
        return myLabel
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    func setup() {
        location = .init()
        location?.delegate = self
        location?.currentLocation()
        mapHelper = .init()
        mapHelper?.delegate = self
        mapHelper?.mapView = mapView
        placesClient = GMSPlacesClient.shared()
        //nearbyPlaces()
    }
    func nearbyPlaces() {
        // Populate the array with the list of likely places.
        // Clean up from previous sessions.
        
//        likelyPlaces.removeAll()
//
//        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
//            if let error = error {
//                // TODO: Handle the error.
//                print("Current Place error: \(error.localizedDescription)")
//                return
//            }
//
//            // Get likely places and add to the list.
//            if let likelihoodList = placeLikelihoods {
//                for likelihood in likelihoodList.likelihoods {
//                    let place = likelihood.place
//                    print(place.name)
//                    self.likelyPlaces.append(place)
//                }
//                //self.placesTbl.animateZoom()
//                self.placesTbl.reloadData()
//            }
//        })
    }
    func fetchPlacesByLocation() {
        if isCounterRun {
            return
        }
        let method = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        ApiManager.instance.paramaters["location"] = "\(lat),\(lng)"
        ApiManager.instance.paramaters["radius"] = 2000
        ApiManager.instance.paramaters["key"] = Constants.googleNotRestrictionKey
        ApiManager.instance.connection(method, type: .get) { (response) in
            let result = try? JSONDecoder().decode(PlacePickerModel.self, from: response ?? Data())
            if result?.status == "OK" {
                self.likelyPlaces.removeAll()
                self.likelyPlaces.append(contentsOf: result?.results ?? [])
                self.placesTbl.reloadData()
            } else {
                self.waitTimer()
            }
            
        }
        
    
    }
    func waitTimer() {
        isCounterRun = true
        self.counterLbl.isHidden = false
        counterLbl.countFrom(0, to: 5, withDuration: 5.0)
        counterLbl.completionBlock = { () in
            self.isCounterRun = false
            self.counterLbl.isHidden = true
            self.fetchPlacesByLocation()
        }
    }
  
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PlacePickerController: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
            self.placesTbl.isScrollEnabled = true
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likelyPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: PlacePickerCell.self, indexPath, register: false)
        cell.model = likelyPlaces[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? PlacePickerCell
        guard let place = cell?.place else { return }
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.didPickPlace(place: place)
        }
    }
    
}
extension PlacePickerController: LocationDelegate, GoogleMapHelperDelegate {
    func didUpdateLocation(lat: Double, lng: Double) {
        self.mapHelper?.updateCamera(lat: lat, lng: lng)
        self.lat = lat
        self.lng = lng
        self.fetchPlacesByLocation()
    }
    func didChangeCameraLocation(lat: Double, lng: Double) {
        self.mapHelper?.setMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
    }
    func didClickOnMap(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
        self.mapHelper?.updateCamera(lat: lat, lng: lng)
        self.fetchPlacesByLocation()
    }
}
