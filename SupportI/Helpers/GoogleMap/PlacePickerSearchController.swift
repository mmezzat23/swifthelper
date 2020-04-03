//
//  PlacePickerController.swift
//  SupportI
//
//  Created by mohamed abdo on 9/2/19.
//  Copyright © 2019 MohamedAbdu. All rights reserved.
//

import UIKit
import GooglePlaces

protocol PlacePickerSearchDelegate: class {
    func didPickSearchPlace(place: PlacePickerModel.PlacePickerResult?)
}

class PlacePickerSearchController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var placesTbl: UITableView! {
        didSet {
            placesTbl.delegate = self
            placesTbl.dataSource = self
        }
    }
    @IBOutlet weak var timerBtn: UIButton!

    
    weak var delegate: PlacePickerSearchDelegate?
    // An array to hold the list of likely places.
    internal var likelyPlaces: [PlacePickerModel.PlacePickerResult] = []
    // The currently selected place.
    internal var selectedPlace: PlacePickerModel.PlacePickerResult?
    private var isCounterRun: Bool = false
    private var timer: TimeHelper?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(false, animated: false)
        setup()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(false, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
    }
    func setup() {

    }
    func fetchPlaces() {
        if isCounterRun {
            return
        }
        let method = "https://maps.googleapis.com/maps/api/place/textsearch/json"
        ApiManager.instance.paramaters["query"] = searchBar.text
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
        self.timerBtn.isHidden = false
        timer = TimeHelper(seconds: 4) { second in
            if second == 4 {
                self.isCounterRun = false
                self.timerBtn.isHidden = true
                self.fetchPlaces()
            }
        }
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PlacePickerSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //fetchPlaces()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchPlaces()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension PlacePickerSearchController: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        searchBar.endEditing(true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likelyPlaces.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: PlacePickerCell.self, indexPath, register: false)
        cell.fetchGMSPlace = false
        cell.model = likelyPlaces[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.didPickSearchPlace(place: self?.likelyPlaces[indexPath.row])
        }
    }
}
