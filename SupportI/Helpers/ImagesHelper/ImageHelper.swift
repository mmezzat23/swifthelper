//
//  ImageLoader.swift
//  homeCheif
//
//  Created by Algazzar on 4/3/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//



import UIKit
extension UIImage {
    public enum ImageFormat {
        case PNG
        case JPEG(CGFloat)
    }
    public func base64(format: ImageFormat) -> String {
        var imageData: NSData
        switch format {
        case .PNG: imageData = self.pngData()! as NSData
        case .JPEG(let compression): imageData = self.jpegData(compressionQuality: compression)! as NSData
        }
        return imageData.base64EncodedString()
    }
    public func base64(format: ImageFormat, option:Bool) -> NSData {
        var imageData: NSData
        
        switch format {
        case .PNG: imageData = self.pngData()! as NSData
        case .JPEG(let compression): imageData = self.jpegData(compressionQuality: compression)! as NSData
        }
        return imageData
    }
    public func decode64(base:String)->UIImage{
        if let decodedData = Data(base64Encoded: base, options: .ignoreUnknownCharacters) {
            return UIImage(data: decodedData)!
        }else{
            return UIImage()
        }
    
    }
    
}
