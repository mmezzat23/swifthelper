import Foundation
import GoogleMaps
import UIKit

extension ARCarMovement {
    func arCarMovement(_ marker: GMSMarker?, withOldCoordinate oldCoordinate: CLLocationCoordinate2D,
                       andNewCoordinate newCoordinate: CLLocationCoordinate2D, inMapview mapView: GMSMapView?, withBearing newBearing: Float) {
        //calculate the bearing value from old and new coordinates
        //
        let calBearing = getHeadingForDirection(fromCoordinate: oldCoordinate, toCoordinate: newCoordinate)
        //found bearing value by calculation
        marker?.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker?.rotation = calBearing
        //found bearing value by calculation when marker add
        marker?.position = oldCoordinate
        //this can be old position to make car movement to new position
        //marker movement animation
        //
        CATransaction.begin()
        CATransaction.setValue(2.0, forKey: kCATransactionAnimationDuration)
        CATransaction.setCompletionBlock({
            if newBearing != 0 {
                marker?.rotation = CLLocationDegrees(newBearing)
                //New bearing value from backend after car movement is done
            } else {
                marker?.rotation = calBearing
                //found bearing value by calculation old and new Coordinates
            }
            // delegate method pass value
            //
            self.delegate?.arCarMovement(marker)

        })
        marker?.position = newCoordinate
        //this can be new position after car moved from old position to new position with animation
        if mapView != nil {
            marker?.map = mapView
        }
        marker?.rotation = calBearing
        CATransaction.commit()
    }
    func getHeadingForDirection(fromCoordinate fromLoc: CLLocationCoordinate2D, toCoordinate toLoc: CLLocationCoordinate2D) -> Double {
        let fLat = degreesToRadians(fromLoc.latitude)
        let fLng = degreesToRadians(fromLoc.longitude)
        let tLat = degreesToRadians(toLoc.latitude)
        let tLng = degreesToRadians(toLoc.longitude)
        let degree = radiansToDegrees(atan2(sin(tLng - fLng) * cos(tLat), cos(fLat) * sin(tLat) - sin(fLat) * cos(tLat) * cos(tLng - fLng)))
        if degree >= 0 {
            return degree
        } else {
            return 360 + degree
        }
    }
}
