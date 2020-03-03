import UIKit

class CustomInteractionController: UIPercentDrivenInteractiveTransition {
    var navigationController: UINavigationController!
    var shouldCompleteTransition = false
    var transitionInProgress = false
    var completionSeed: CGFloat {
        return 1 - percentComplete
    }

    func attachToViewController(viewController: UIViewController) {
        navigationController = viewController.navigationController
        setupGestureRecognizer(view: viewController.view)
    }

    private func setupGestureRecognizer(view: UIView) {
            view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:))))
    }

    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let viewTranslation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        let width = Int((gestureRecognizer.view?.width)!)
        switch gestureRecognizer.state {
        case .began:
            transitionInProgress = true
            //navigationController.popViewController(animated: true)
        case .changed:
            var const: CGFloat = 0
            let int = Int(viewTranslation.x)
            if getAppLang() == "ar"{
                if int > 0 {
                    let unInt: Int = abs(int)
                    const = CGFloat(fminf(fmaxf(Float( unInt / (width/3)), 0.0), 1.0))
                    shouldCompleteTransition = const > 0.5
                } else {
                    shouldCompleteTransition = false
                }

            } else {
                if int < 0 {
                    let unInt: Int = abs(int)
                    const = CGFloat(fminf(fmaxf(Float( unInt / (width/3)), 0.0), 1.0))
                    shouldCompleteTransition = const > 0.5
                } else {
                    shouldCompleteTransition = false
                }
            }

            update(const)
        case .cancelled, .ended:
            transitionInProgress = false
            if !shouldCompleteTransition || gestureRecognizer.state == .cancelled {
                cancel()
            } else {
                finish()
                navigationController.popViewController(animated: true)
            }
        default:
            break
            //println("Swift switch must be exhaustive, thus the default")
        }
    }
}
