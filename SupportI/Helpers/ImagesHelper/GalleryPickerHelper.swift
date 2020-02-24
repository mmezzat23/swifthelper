//  GalleryPickerHelper
//  Created by Mohamed Abdo.

import UIKit
import MobileCoreServices
import AVFoundation

protocol ImagePickerDelegate {
    func didPickItem(image: UIImage)
    func didPickItem(url: URL?)
}
extension ImagePickerDelegate {
    func didPickItem(url: URL?) {
        
    }
}

internal typealias VideoPickerDelegate = UIImagePickerControllerDelegate & UINavigationControllerDelegate

internal enum PickingType {
    case picture, video
}

internal final class GalleryPickerHelper: NSObject, VideoPickerDelegate {
    
    private var picker: UIImagePickerController?
    private var _delegate: ImagePickerDelegate?
    private var viewController: UIViewController!
    internal var delegate: ImagePickerDelegate? {
        set {
            _delegate = newValue
            viewController = _delegate as? UIViewController
        } get {
            return _delegate
        }
    }
    
    internal var onPickImage: ((UIImage) -> Void)?,
    onCancel: (() -> Void)?,
    placeholderImage = UIImage(),
    alertTitle, alertMessage: String?,
    tintColor = UIColor.darkGray,
    cameraTitle = "camera.lan".localized, libraryTitle = "photo.library.lan".localized, cancelTitle = "cancel.lan".localized,
    onError: (() -> Void)?,
    onPickVideoURL: ((URL) -> Void)?
    
    /// TODO:- picking image
    internal func pick(in screen: UIViewController?, type: PickingType = .picture) {
        picker = UIImagePickerController()
        picker?.delegate = self
        picker?.allowsEditing = true
        picker?.mediaTypes = [ type == .picture ? kUTTypeImage as String : kUTTypeMovie as String]
        let alert = UIAlertController(title: alertTitle ?? "", message: alertMessage ?? "", preferredStyle: .alert)
        alert.view.layer.cornerRadius = 4.0
        alert.view.tintColor = tintColor
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { [weak self] (_) in
            NSLog("tell user something in `onCancel` block because he cancel picking")
            self?.onCancel?()
            self?.onCancel = .none
        }))
        alert.addAction(cameraAction(in: screen))
        alert.addAction(libraryAction(in: screen))
        screen?.present(alert, animated: true)
    }
    
    private func cameraAction(in screen: UIViewController?) -> UIAlertAction {
        return UIAlertAction(title: cameraTitle, style: .default, handler: { [weak self] (_) in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                NSLog("tell user something in `onError` block because camera not available")
                self?.onError?()
                self?.onError = .none
                return
            }
            self?.picker?.sourceType = .camera
            guard let picker = self?.picker else {
                NSLog("use `onError` block because ImagePicker is null")
                self?.onError?()
                self?.onError = .none
                return
            }
            screen?.present(picker, animated: true)
        })
    }
    
    private func libraryAction(in screen: UIViewController?) -> UIAlertAction {
        return UIAlertAction(title: libraryTitle, style: .default, handler: { [weak self] (_) in
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                NSLog("tell user something in `onError` block because photoLibrary not available")
                self?.onError?()
                self?.onError = .none
                return
            }
            self?.picker?.sourceType = .photoLibrary
            guard let picker = self?.picker else {
                NSLog("use `onError` block because ImagePicker is null")
                self?.onError?()
                self?.onError = .none
                return
            }
            screen?.present(picker, animated: true)
        })
    }
    
    internal func getThumbnailImage(for url: URL) -> UIImage? {
        let asset = AVAsset.init(url: url)
        let imageGenerator = AVAssetImageGenerator.init(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        guard let cgImage = try? imageGenerator.copyCGImage(at: CMTimeMakeWithSeconds(1, preferredTimescale: 1),
                                                            actualTime: .none) else { return .none }
        return UIImage.init(cgImage: cgImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        NSLog("tell user something in `onCancel` block because he cancel picking")
        picker.dismiss(animated: true, completion: onCancel)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            onPickVideoURL?(videoURL)
            delegate?.didPickItem(url: videoURL)
        } else {
            var pickedImage = placeholderImage
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                pickedImage = editedImage
            } else if let originalPhoto = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                pickedImage = originalPhoto
            }
            NSLog("user picking image you can find it in `onPickImage` block")
            onPickImage?(pickedImage)
            delegate?.didPickItem(image: pickedImage)
            delegate?.didPickItem(url: getImageURL(info: info))
        }
        picker.dismiss(animated: true)
    }
    
    
    func getImageURL(info: [UIImagePickerController.InfoKey : Any]) -> URL? {
        var photoURL: URL?
        
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let data = image.pngData()! as NSData
            data.write(toFile: localPath!, atomically: true)
            //let imageData = NSData(contentsOfFile: localPath!)!
            photoURL = URL.init(fileURLWithPath: localPath!)//NSURL(fileURLWithPath: localPath!)
            return photoURL
        } else {
            return nil
        }
    }
}


