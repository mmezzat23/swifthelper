
import UIKit
import UserNotifications
import CoreData
import Firebase

extension UINavigationController {
    var rootViewController : UIViewController? {
        return viewControllers.first
    }
}


extension FirebaseNotificationDelegate {
    func convertToDictionary(text: String?) -> [String: Any]? {
        if let data = text?.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func convertToNSDictionary(text: String?) -> NSDictionary? {
        if let data = text?.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func convertToNSData(text: String?) -> Data? {
        if let data = text?.data(using: .utf8) {
            return data
        }
        return nil
    }
    
}





fileprivate func checkTopController() -> Bool {
    
    if let _ = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController?.childViewControllers.last{
        return true
    }else{
        return false
    }
}

