//class PushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
//    let animationDuration = 0.5
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return animationDuration
//    }
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        
//        let delay = 0.35
//        let screenHeight = UIScreen.main.bounds.height
//        let screenWidth = UIScreen.main.bounds.width
//        let containerView = transitionContext.containerView
//        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//        
//        containerView.addSubview(toViewController!.view)
//        
//        toViewController!.view.frame = CGRect(x: screenWidth * -1, y: 0, width: screenWidth, height: screenHeight)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//            
//            UIView.animate(withDuration: 1, delay: delay, options: [.curveLinear, .curveEaseInOut], animations: {
//                toViewController!.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
//            }, completion: { finished in
//                let cancelled = transitionContext.transitionWasCancelled
//                transitionContext.completeTransition(!cancelled)
//            })
//            
//        }
//        
//        
//    }
//}

import UIKit

public extension UINavigationController {

    /**
     Pop current view controller to previous view controller.
     
     - parameter type:     transition animation type.
     - parameter duration: transition animation duration.
     */
    func pop(transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {

        self.addTransition(transitionType: type, duration: duration)
        self.popViewController(animated: false)
    }

    /**
     Push a new view controller on the view controllers's stack.
     
     - parameter vc:       view controller to push.
     - parameter type:     transition animation type.
     - parameter duration: transition animation duration.
     */
    func push(viewController vcr: UIViewController, transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.pushViewController(vcr, animated: false)
    }

    private func addTransition(transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {

        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType(rawValue: type)
        self.view.layer.add(transition, forKey: nil)
    }

}
