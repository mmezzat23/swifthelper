//
//  CustomViewController.swift
//  SupportI
//
//  Created by mohamed abdo on 2/16/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import UIKit

class CustomViewController: BaseController {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.swipeButtomRefresh {
            if case self.viewModel?.runPaginator() = true {
                self.viewModel?.fetchData()
            }
        }
    }

    var helper: GalleryPickerHelper?
    var viewModel: TestViewModel?
    var tableview: UITableView!
    var array: [Any] = []
    var locationHelper: LocationHelper?
    var googleMap: GoogleMapHelper?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchData()
        // Do any additional setup after loading the view.
        let pickerHelper = controller(PickerViewHelper.self)
        pickerHelper.source = array
        pickerHelper.didSelectClosure = { row in

        }
        pickerHelper.didSelectItemClosure = { item in

        }
        //pickerHelper.delegate = self
        pushPop(vcr: pickerHelper)

        locationHelper = LocationHelper()
        locationHelper?.onUpdateLocation = { degree in
            self.googleMap?.updateCamera(lat: degree?.latitude ?? 0, lng: degree?.longitude ?? 0)
        }
        //locationHelper?.delegate = self
//        locationHelper?.useOnlyoneTime = false
//        locationHelper?.updateLocationInDistance = 100
//        locationHelper?.useInBackground = true
        locationHelper?.reload()

        googleMap = .init()
        googleMap?.delegate = self
        googleMap?.mapView = nil

    }
    override func bind() {

        viewModel?.model.bind({ (_) in
            self.tableview.stopSwipeButtom()
            self.tableview.stopSwipeTop()
        })
    }

}

extension CustomViewController: GoogleMapHelperDelegate {
    func didChangeCameraLocation(lat: Double, lng: Double) {

    }
    func didClickOnMap(lat: Double, lng: Double) {

    }

}
