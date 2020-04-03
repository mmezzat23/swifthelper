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
    @IBOutlet weak var timerBtn: UIButton!

    var location: LocationHelper?
    var lat: Double = 0
    var lng: Double = 0
    var mapHelper: GoogleMapHelper?
    weak var delegate: PlacesPickerDelegate?
    /** places **/
    internal var placesClient: GMSPlacesClient!
    // An array to hold the list of likely places.
    internal var likelyPlaces: [PlacePickerModel.PlacePickerResult] = []
    // The currently selected place.
    internal var selectedPlace: PlacePickerModel.PlacePickerResult?
    private var  currentLocationPlace: PlacePickerModel.PlacePickerResult?
    
    // counter waiting
    private var isCounterRun: Bool = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(false, animated: false)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    @objc func search() {
        let storyboard = UIStoryboard(name: "PlacesPickerHelper", bundle: nil)
        guard let navVC = storyboard.instantiateViewController(withIdentifier: "PlaceSearchNav") as? UINavigationController else { return }
        let searchVC = navVC.topViewController as? PlacePickerSearchController
        searchVC?.delegate = self
        self.present(navVC, animated: true, completion: nil)
    }
    func setup() {
        location = .init()
        location?.delegate = self
        location?.currentLocation()
        mapHelper = .init()
        mapHelper?.delegate = self
        mapHelper?.mapView = mapView
        mapView.isMyLocationEnabled = true
        placesClient = GMSPlacesClient.shared()
        //nearbyPlaces()
    }
    func nearbyPlaces() {
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
                guard let currentLocationPlace = self.currentLocationPlace else { return }
                self.likelyPlaces.append(currentLocationPlace)
                self.likelyPlaces.append(contentsOf: result?.results ?? [])
                self.placesTbl.reloadData()
            } else {
                self.waitTimer()
            }
        }
    }
    func initCurrentLocationPlace(title: String? = nil, snippet: String? = nil) {
        currentLocationPlace = PlacePickerModel.PlacePickerResult()
        currentLocationPlace?.geometry = .init()
        currentLocationPlace?.geometry?.location = .init()
        currentLocationPlace?.geometry?.location?.lat = lat
        currentLocationPlace?.geometry?.location?.lng = lng
        currentLocationPlace?.icon = nil
        if title != nil {
            currentLocationPlace?.name = title
        }
        if snippet != nil {
            currentLocationPlace?.vicinity = snippet
        }
    }
    func waitTimer() {
        isCounterRun = true
        self.timerBtn.isHidden = false
        self.timerBtn.setTitle("Loading...", for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            self.isCounterRun = false
            self.timerBtn.isHidden = true
            self.fetchPlacesByLocation()
        }
    
    }
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PlacePickerController: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height {
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
        let place = likelyPlaces[indexPath.row]
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.didPickPlace(place: place)
        }
//        let cell = tableView.cellForRow(at: indexPath) as? PlacePickerCell
//        guard let place = cell?.place else { return didSelectWithoutGMSPlace(path: indexPath.row) }
//        self.dismiss(animated: true) { [weak self] in
//            self?.delegate?.didPickPlace(place: place)
//        }
    }
    func didSelectWithoutGMSPlace(path: Int) {
    }
}
extension PlacePickerController: LocationDelegate, GoogleMapHelperDelegate {
    func didUpdateLocation(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
        self.mapHelper?.address(lat: lat, lng: lng, handler: { (title, snippet) in
            self.initCurrentLocationPlace(title: title, snippet: snippet)
            self.mapHelper?.updateCamera(lat: lat, lng: lng)
        })
    }
    func didChangeCameraLocation(lat: Double, lng: Double) {
        self.mapHelper?.setMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        self.fetchPlacesByLocation()
    }
    func didTapOnMap(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
        self.mapHelper?.address(lat: lat, lng: lng, handler: { (title, snippet) in
            self.initCurrentLocationPlace(title: title, snippet: snippet)
            self.mapHelper?.updateCamera(lat: lat, lng: lng)
        })
    }
}

extension PlacePickerController: PlacePickerSearchDelegate {
    func didPickSearchPlace(place: PlacePickerModel.PlacePickerResult?) {
        guard let lat = place?.geometry?.location?.lat, let lng = place?.geometry?.location?.lng else { return }
        self.lat = lat
        self.lng = lng
        self.currentLocationPlace = place
        self.fetchPlacesByLocation()
        self.mapHelper?.updateCamera(lat: lat, lng: lng)
    }
}
