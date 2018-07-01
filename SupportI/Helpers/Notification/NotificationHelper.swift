
import UIKit
import UserNotifications
import CoreData
import Firebase

extension UINavigationController {
    var rootViewController : UIViewController? {
        return viewControllers.first
    }
}

fileprivate let gcmMessageIDKey = "gcm.message_id"

fileprivate func convertToDictionary(text: String?) -> [String: Any]? {
    if let data = text?.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}
fileprivate func convertToNSDictionary(text: String?) -> NSDictionary? {
    if let data = text?.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

fileprivate func convertToNSData(text: String?) -> Data? {
    if let data = text?.data(using: .utf8) {
       return data
    }
    return nil
}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID  = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        //print("here it  is\(userInfo)")
        
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
       
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        notificationControl(notification: userInfo)
        completionHandler()
    }
}




func notificationControl(notification:[AnyHashable:Any])  {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let root = UIApplication.shared.keyWindow?.rootViewController as! SWRevealViewController
    guard let type = notification["gcm.notification.type"] as? String else {return}
    print(type)
    switch type{
    default:
        break
    }
}




fileprivate func checkTopController()->Bool{
    
    if let _ = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController?.childViewControllers.last{
        return true
    }else{
        return false
    }
}
fileprivate func pushFromNotification(identifier:String , useVC:Bool = true){
    
    let nav = identifier+"Nav"
    var controller = ""
    if useVC{
        controller = identifier+"VC"
    }else{
        controller = identifier
    }
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    if let topController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController?.childViewControllers.last{
        
        let vc = storyboard.instantiateViewController(withIdentifier: controller)
        topController.navigationController?.pushViewController(vc, animated: true)
    }
    else{
        let vc = storyboard.instantiateViewController(withIdentifier: nav)
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
}

fileprivate func pushFromNotification(nav:String,controller:String){
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    if let topController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController?.childViewControllers.last{
        
        let vc = storyboard.instantiateViewController(withIdentifier: controller)
        topController.navigationController?.pushViewController(vc, animated: true)
    }
    else{
        let vc = storyboard.instantiateViewController(withIdentifier: nav)
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
}

fileprivate func pushMenuNotification(nav:String,controller:String){
    //let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //
    //    let root = UIApplication.shared.keyWindow?.rootViewController as! SWRevealViewController
    //
    //    if let controller = root.frontViewController?.childViewControllers.last{
    //        controller.pushVC(storyboard: "Main", viewController: "MyNotifcationsVC", animated: true)
    //    }
    //    else{
    //        let vc = storyboard.instantiateViewController(withIdentifier: nav)
    //        root.pushFrontViewController(vc, animated: true)
    //    }
    
}
// [END ios_10_message_handling]


