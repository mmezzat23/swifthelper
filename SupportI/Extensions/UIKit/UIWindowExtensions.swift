import UIKit

extension UIWindow {
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(vcr: rootViewController)
        }
        return nil
    }
    class func getVisibleViewControllerFrom(vcr: UIViewController) -> UIViewController {
        if vcr.isKind(of: UINavigationController.self) {
            guard let navigationController = vcr as? UINavigationController else { return UIViewController() }
            return UIWindow.getVisibleViewControllerFrom( vcr: navigationController.visibleViewController!)
        } else if vcr.isKind(of: UITabBarController.self) {
            guard let tabBarController = vcr as? UITabBarController else { return UIViewController() }
            return UIWindow.getVisibleViewControllerFrom(vcr: tabBarController.selectedViewController!)
        } else {
            if let presentedViewController = vcr.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vcr: presentedViewController)
            } else {
                return vcr
            }
        }
    }
}
