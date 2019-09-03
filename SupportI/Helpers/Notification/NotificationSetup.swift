

import UIKit
import UserNotifications
import CoreData
import Firebase



protocol FirebaseNotificationDelegate: class {
    func setupFirebase()
    func subscribeFirebase()
    func unSubscribeFirebase()
    func notificationControl(notification: [AnyHashable: Any], closure: SoundHandler? )
}
extension FirebaseNotificationDelegate where Self: AppDelegate {
    func setupFirebase() {
        let application = UIApplication.shared
        FirebaseApp.configure()
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
    func unSubscribeFirebase() {
        let application = UIApplication.shared
        Messaging.messaging().delegate = nil
        UNUserNotificationCenter.current().delegate = nil
        application.unregisterForRemoteNotifications()
    }
    func subscribeFirebase() {
        let application = UIApplication.shared
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
    }
}
