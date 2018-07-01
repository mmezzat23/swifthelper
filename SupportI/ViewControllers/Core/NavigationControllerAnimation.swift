import UIKit

fileprivate let customNavigationAnimationController = CustomNavigationAnimationController()
//fileprivate let customInteractionController:CustomInteractionController?
extension BaseController: UINavigationControllerDelegate ,UIViewControllerTransitioningDelegate{
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentAnimationController()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomDismissAnimationController()
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            if self.pushTranstion{
                customNavigationAnimationController.reverse = operation == .pop
                return customNavigationAnimationController
            }else{
                return nil
            }
            //customInteractionController.attachToViewController(viewController: toVC)
           
        }else if operation == .pop{
            if self.popTranstion {
                return CustomDismissAnimationController()
            }else{
                return nil
            }
        }else{
            return nil
        }
        
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
        //return customInteractionController.transitionInProgress ? customInteractionController : nil
    }
    
    
}
