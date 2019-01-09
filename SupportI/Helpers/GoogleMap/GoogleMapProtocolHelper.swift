//
//  MapProtocolHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//
import MapKit

protocol GoogleMapHelperDelegate:class {
    func locationCallback(lat:Double , lng:Double)
    func locationCallback(name:String?)
    func locationCallback(address:String?)
  
}
extension GoogleMapHelperDelegate where Self:Any{
    func locationCallback(lat:Double , lng:Double){
        
    }
    func locationCallback(name:String?){
        
    }
    func locationCallback(address:String?){
        
    }
    
}
