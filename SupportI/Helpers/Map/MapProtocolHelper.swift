//
//  MapProtocolHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//
import MapKit

protocol MapHelperDelegate {
    func locationCallback(lat:Double , lng:Double)
    func searchCallBack(lat:Double , lng:Double)
    func searchCallBack(results:[MKMapItem])
    func addressCallBack(address:String)
    func customAnnotation()->[CustomAnnotation<Any>]
    func didselectAnnotationCallBack(annotation:CustomAnnotation<Any>)
    func upperViewMarker(marker:CustomAnnotation<Any>)->UIView?
    func upperViewAction(marker:CustomAnnotation<Any>)
    
}
extension MapHelperDelegate where Self:Any{
    func locationCallback(lat:Double , lng:Double){
        
    }
    func addressCallBack(address:String){
        
    }
    func searchCallBack(lat:Double , lng:Double){
        
    }
    func searchCallBack(results:[MKMapItem]){
        
    }
    func customAnnotation()->[CustomAnnotation<Any>]{
        return []
    }
    
    func didselectAnnotationCallBack(annotation:CustomAnnotation<Any>){
        
    }
    func upperViewMarker(marker:CustomAnnotation<Any>)->UIView?{
        return nil
    }
    func upperViewAction(marker:CustomAnnotation<Any>){
        
    }

}
