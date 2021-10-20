//
//  Addproductmedia.swift
//  Wndo
//
//  Created by Adam on 19/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
import BMPlayer
import Publitio
class Addproductmedia: BaseController {
    @IBOutlet weak var viewvedio: UIView!
    @IBOutlet weak var play: UIImageView!
    @IBOutlet weak var player: BMPlayer!
    
    @IBOutlet weak var addvediolbl: UILabel!
    @IBOutlet weak var continu: UIButton!
    @IBOutlet weak var savedraft: UIButton!
    @IBOutlet weak var vediohight: NSLayoutConstraint!
    @IBOutlet weak var vedioline: UIView!
    @IBOutlet weak var vediolinehight: NSLayoutConstraint!
    @IBOutlet weak var vedios: UICollectionView!
    @IBOutlet weak var photos: UICollectionView!
    @IBOutlet weak var delete: UIImageView!
    var productid = ""
    var selectedImages: [UIImage] = []
    var selectedImagesURL: [URL] = []
    var picker: GalleryPickerHelper?
    var parameters : [String : Any] = [:]
    var viewModel : SallerViewModel?
    let imagePickerController = UIImagePickerController()
    var videoURL: URL?
    var isedit = false
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        setup()
        if (videoURL == nil){
            play.isHidden = true
        }
        if (isedit == false){
            vedioline.isHidden = true
            vediolinehight.constant = 0
            vedios.isHidden = true
            vediohight.constant = 0
            addvediolbl.isHidden = true
        }
//        68d372bc-8e2d-46cf-ab3d-7c8607c9e1bb
        // Do any additional setup after loading the view.
    }
    func setup() {
        viewModel = .init()
        viewModel?.delegate = self
        photos.delegate = self
        photos.dataSource = self
        picker = .init()
        picker?.onPickImageURL = { [self] url in
            selectedImagesURL.append(url!)
                    
                }
        picker?.onPickImage = { [self] image in
            selectedImages.append(image)
            photos.reloadData()
                }
        viewvedio.UIViewAction { [self] in
            imagePickerController.sourceType = .savedPhotosAlbum
             imagePickerController.delegate = self
             imagePickerController.mediaTypes = ["public.movie"]
            present(imagePickerController, animated: true, completion: nil)
        }
    }
   
    @IBAction func `continue`(_ sender: Any) {
    }
    
    @IBAction func savedraft(_ sender: Any) {
    }
    
}
extension Addproductmedia: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:  120 , height: self.photos.height)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.cell(type: ImagesCollectionViewCell.self, indexPath)
        cell.model = selectedImages[safe: indexPath.row]
        cell.delete.UIViewAction { [self] in
            selectedImages.remove(at: indexPath.row)
            selectedImagesURL.remove(at: indexPath.row)
            photos.reloadData()
        }
        if (indexPath.row == selectedImages.count){
            cell.image.borderColor = .clear
            cell.image.borderWidth = 0
            cell.delete.isHidden = true
            cell.image?.cornerRadius = 0
        }
        cell.image.UIViewAction { [self] in
            if (indexPath.row == selectedImages.count){
                self.picker?.pick(in: self)
            }
        }
        return cell
    }
}
extension Addproductmedia : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            dismiss(animated: true, completion: nil)
            guard let movieUrl = info[.mediaURL] as? URL else { return }
        videoURL = movieUrl
        player.isHidden = false
        let asset = BMPlayerResource(url: videoURL!,
                                     name: "WNDO")
        player.setVideo(resource: asset)
        self.indicatorView.startAnimating()
        Publitio.shared.filesCreateWithCompression(localMediaPath: videoURL, videoQuality: .quality960x540, mimeType: .mov, fileUrl: nil, publicId: nil, title: nil, description: nil, tags: nil, privacy: nil, optionDownload: nil, optionTransform: nil, optionAd: nil, completion: { (success, result) in
                            DispatchQueue.main.async {
                                print(success,result)
                                print(result)
                                self.indicatorView.stopAnimating()
                               // playCompressedVideo(compressedObj: res)
                            }
                        })


            // work with the video URL
    }
}
