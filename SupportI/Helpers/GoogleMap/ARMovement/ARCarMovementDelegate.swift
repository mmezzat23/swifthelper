
import Foundation
import GoogleMaps
import UIKit

func degreesToRadians(_ x: Double) -> Double {

    return .pi * x / 180.0
}
func radiansToDegrees(_ x: Double) -> Double {
    return x * 180.0 / .pi
}
// MARK: - delegate protocol
protocol ARCarMovementDelegate: NSObjectProtocol {
    /**
     *  Tells the delegate that the specified marker will be work with animation.
     */
    func arCarMovement(_ movedMarker: GMSMarker?)
}

class ARCarMovement: NSObject {
    // MARK: - Public properties
    /**
     *  The object that acts as the delegate of the ARCarMovement.
     */
    
    weak var delegate: ARCarMovementDelegate?
    
    /**
     *  assign the specified details to be work with animation for the Marker.
     */
  
}
