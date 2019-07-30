//
//  imagePickerHelper.swift
//  homeCheif
//
//  Created by Mohamed Abdu on 4/18/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit

protocol ImagePickerDelegate {
    func pickerCallback(image:UIImage)
    func pickerCallback(image:URL?)
}
extension ImagePickerDelegate {
    func pickerCallback(image:URL?) {
        
    }
}
class ImagePickerHelper:NSObject,UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    var viewController:UIViewController!
    private var _delegate:ImagePickerDelegate?
    var run:Bool = true
    var delegate:ImagePickerDelegate?{
        set{
            _delegate = newValue
            viewController = _delegate as? UIViewController
            if(self.run){
                self.openPicker()
            }
        }get{
            return _delegate
        }
    }
    var imagepicker = UIImagePickerController()
    
    required init(_ delegate:ImagePickerDelegate? , run:Bool = true) {
        super.init()
        self.run = run
        self.delegate = delegate
    }
    convenience override init() {
        self.init(nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        var photoURL: URL?
        //self.imagePickerView.image = image
        //Use image name from bundle to create NSData
        //Now use image to create into NSData format
        //let base64 = image.base64(format: .JPEG(0.1))
        
        //OR next possibility
        //let view controlller as VC
        
        
        if let imgUrl = info[UIImagePickerControllerImageURL] as? URL {
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let data = UIImagePNGRepresentation(image)! as NSData
            data.write(toFile: localPath!, atomically: true)
            //let imageData = NSData(contentsOfFile: localPath!)!
            photoURL = URL.init(fileURLWithPath: localPath!)//NSURL(fileURLWithPath: localPath!)
            
        }
        
        picker.dismiss(animated: true, completion: {
            self.delegate?.pickerCallback(image: image)
            self.delegate?.pickerCallback(image: photoURL)
        })
        
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagepicker.sourceType = UIImagePickerControllerSourceType.camera
            imagepicker.allowsEditing = true
            self.viewController?.present(imagepicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title:translate("warning"), message: translate("you_don't_have_camera"), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: translate("ok"), style: .default, handler: nil))
            self.viewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagepicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //imagepicker.allowsEditing = true
        self.viewController?.present(imagepicker, animated: true, completion: nil)
    }
    func openPicker(){
        self.imagepicker.delegate = self
        
        let alert = UIAlertController(title: translate("choose_image"), message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: translate("camera"), style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: translate("gallery"), style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: translate("cancel"), style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.permittedArrowDirections = .up
            alert.popoverPresentationController?.sourceView = self.viewController?.view
            
        default:
            break
        }
        
        self.viewController?.present(alert, animated: true, completion: nil)
    }
    
}
