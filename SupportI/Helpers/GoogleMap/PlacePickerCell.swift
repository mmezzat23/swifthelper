//
//  PlacePickerCell.swift
//  SupportI
//
//  Created by mohamed abdo on 9/2/19.
//  Copyright © 2019 MohamedAbdu. All rights reserved.
//

import UIKit
import GooglePlaces

class PlacePickerCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var placeIcon: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    var placesClient: GMSPlacesClient? = GMSPlacesClient.shared()
    var place: GMSPlace?
    var fetchGMSPlace: Bool = true
    func setup() {
        guard let model = model as? PlacePickerModel.PlacePickerResult else { return }
        self.placeName.text = model.name
        self.placeAddress.text = model.vicinity
        self.placeIcon.setImage(url: model.icon)
        // Specify the place data types to return (in this case, just photos).
        if fetchGMSPlace {
            fetchPlaceDetail()
        }
    }
    func fetchPlaceDetail() {
        guard let model = model as? PlacePickerModel.PlacePickerResult else { return }
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.photos.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) |
            UInt(GMSPlaceField.coordinate.rawValue) |
            UInt(GMSPlaceField.formattedAddress.rawValue) |
            UInt(GMSPlaceField.name.rawValue))!
        placesClient?.fetchPlace(fromPlaceID: model.place_id ?? "",
                                 placeFields: fields,
                                 sessionToken: nil, callback: { (place: GMSPlace?, error: Error?) in
                                    if let error = error {
                                        print("An error occurred: \(error.localizedDescription)")
                                        return
                                    }
                                    if let place = place {
                                        self.place = place
                                        self.placeName.text = place.name
                                        self.placeAddress.text = place.formattedAddress
                                        // Get the metadata for the first photo in the place photo metadata list.
                                        guard let photoMetadata: GMSPlacePhotoMetadata = place.photos?.first else { return }
                                        // Call loadPlacePhoto to display the bitmap and attribution.
                                        self.placesClient?.loadPlacePhoto(photoMetadata, callback: { (photo, error) -> Void in
                                            if let error = error {
                                                print("Error loading photo metadata: \(error.localizedDescription)")
                                                return
                                            } else {
                                                // Display the first image and its attributions.
                                                self.placeIcon?.image = photo
                                            }
                                        })
                                    }
        })
    }

}
