//
//  MultiSelectImagesHelper.swift
//  Jalab
//
//  Created by Mohamed Abdu on 7/30/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import Foundation
import BSImagePicker
import Photos

protocol MultiSelectImagesDelegate: class {
    func didFinish(_ images: [UIImage])
    func didFinish(urls: [URL])
}
extension MultiSelectImagesDelegate {
    func didFinish(urls: [URL]) {
    }
}
class MultiSelectImagesHelper: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Alertable {
    var images: [UIImage] = []
    var urls: [URL] = []
    var imagesCollection: UICollectionView?
    var collectionHeight: NSLayoutConstraint?
    var collectionParentTop: NSLayoutConstraint?
    weak var delegate: MultiSelectImagesDelegate?

    init(delegate: MultiSelectImagesDelegate? = nil, collection: UICollectionView? = nil,
         height: NSLayoutConstraint? = nil, parentTop: NSLayoutConstraint? = nil) {
        super.init()
        self.delegate = delegate
        self.imagesCollection = collection
        self.collectionHeight = height
        self.collectionParentTop = parentTop
    }

    func initPicker() {
        let vcr = BSImagePickerViewController()
        vcr.maxNumberOfSelections = 5
        let topVC = UIApplication.topMostController()
        topVC.bs_presentImagePickerController(vcr, animated: true,
                                              select: { (asset: PHAsset) -> Void in
                                                // User selected an asset.
                                                // Do something with it, start upload perhaps?
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            // Do something, cancel upload?
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish: { (assets: [PHAsset]) -> Void in
            // User finished with these assets
            print(assets)
            //self.startLoading()
            //self.images = self.getImageFromAsset(asset: assets)
            self.getImageFromAsset(asset: assets)
            //self.reloadCollectionImage()
            //self.imagesCollection.reloadData()
        }, completion: nil)
    }

    func getImageFromAsset(asset: [PHAsset]) {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
        option.resizeMode = .fast
        option.isSynchronous = false
        DispatchQueue.main.async {
            self.images = []
            self.imagesCollection?.reloadData()
            for item in asset {

                manager.requestImageData(for: item, options: option) { [weak self] (data, imageString, _, info) in
                    var thumbnail: UIImage?
                    guard let data = data  else { return }
                    thumbnail = UIImage(data: data)
                    if thumbnail != nil {
                        self?.images.append(thumbnail!)
                    }

                    if !(imageString!.contains("HEIC") || imageString!.contains("heic")) {
                        if let info = info {
                            if info.keys.contains(NSString(string: "PHImageFileURLKey")) {
                                if let path = info[NSString(string: "PHImageFileURLKey")] as? NSURL {
                                    self?.urls.append(path as URL)
                                }
                            }
                        }
                    }
                    if (self?.images.count ?? 0) == asset.count {
                        self?.reloadCollection()
                        self?.delegate?.didFinish(self?.images ?? [])
                        self?.delegate?.didFinish(urls: self?.urls ?? [])
                    }
                }
            }
        }
    }
    func reloadCollection() {
        if self.images.count  < 1 {
            self.imagesCollection?.isHidden = true
            self.collectionHeight?.constant = 0
            self.collectionParentTop?.constant = 0
        } else {
            self.imagesCollection?.isUserInteractionEnabled = false
            self.imagesCollection?.isHidden = false
            self.collectionParentTop?.constant = 30
            if self.images.count > 4 {
                self.collectionHeight?.constant = 136
            } else {
                self.collectionHeight?.constant = 67
            }
            self.imagesCollection?.dataSource = self
            self.imagesCollection?.delegate = self
            self.imagesCollection?.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 67, height: 67)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.images.count)
        return self.images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: MultiImageCell.self, indexPath )
        cell.imageView.image = nil
        cell.imageView.image = self.images[indexPath.item]
        cell.imageView.borderWidth = 1
        cell.imageView.borderColor = UIColor.black.withAlphaComponent(0.15)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var actions: [String: Any] = [:]
        actions["delete.lan".localized] = 0
        createActionSheet(title: "alert.lan".localized, actions: actions) { (_) in
            self.images.remove(at: indexPath.row)
            self.urls.remove(at: indexPath.row)
            self.reloadCollection()
            self.delegate?.didFinish(self.images)
            self.delegate?.didFinish(urls: self.urls)
        }
    }

}
