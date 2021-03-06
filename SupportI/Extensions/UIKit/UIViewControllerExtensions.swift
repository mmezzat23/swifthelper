//
//  UIViewControllerExtensions.swift
//  SwifterSwift
//
//  Created by Emirhan Erdogan on 07/08/16.
//  Copyright © 2016 SwifterSwift
//

import UIKit
//fileprivate var hideNavVar = [String:Bool]()
//extension UIViewController{
//    @IBInspectable public var hideNav:Bool{
//        set{
//            let typeOf = String(describing: type(of: self))
//            hideNavVar[typeOf] = newValue
//            if newValue{
//                self.navigationController?.setNavigationBarHidden(true, animated: false)
//            }else{
//                self.navigationController?.setNavigationBarHidden(false, animated: false)
//            }
//        }get{
//            let typeOf = String(describing: type(of: self))
//            if let _ = hideNavVar[typeOf]{
//                return hideNavVar[typeOf]!
//            }else{
//                return false
//            }
//        }
//    }
//}

// MARK: - Properties
public extension UIViewController {

	/// SwifterSwift: Check if ViewController is onscreen and not hidden.
    var isVisible: Bool {
		// http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
		return self.isViewLoaded && view.window != nil
	}

}

// MARK: - Methods
public extension UIViewController {

	/// SwifterSwift: Assign as listener to notification.
	///
	/// - Parameters:
	///   - name: notification name.
	///   - selector: selector to run with notified.
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
		NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
	}

	/// SwifterSwift: Unassign as listener to notification.
	///
	/// - Parameter name: notification name.
    func removeNotificationObserver(name: Notification.Name) {
		NotificationCenter.default.removeObserver(self, name: name, object: nil)
	}

	/// SwifterSwift: Unassign as listener from all notifications.
    func removeNotificationsObserver() {
		NotificationCenter.default.removeObserver(self)
	}

    /// SwifterSwift: Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - buttonTitles: (Optional)list of button titles for the alert. Default button i.e "OK" will be shown if this paramter is nil
    ///   - highlightedButtonIndex: (Optional) index of the button from buttonTitles that should be highlighted. If this parameter
    //is nil no button will be highlighted
    ///   - completion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an argument
    /// - Returns: UIAlertController object (discardable).
    @discardableResult func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil,
                                      highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }

        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }

}
