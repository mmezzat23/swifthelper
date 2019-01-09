//
//    RootClass.swift
//
//    Create by imac on 29/4/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation



class UserRoot : Decodable{
    struct Static {
        static var instance: UserRoot?
    }
    
    class var instance : UserRoot {
        
        if(Static.instance == nil) {
            Static.instance = UserRoot()
        }
        Static.instance?.getUser()
        return Static.instance!
    }
    
    var result : User?
    var errors : Errors?
    var expires_in : Int?
    var access_token : String?
    var refresh_token : String?
    var message : String?
    var json:String?
    
    public static func convertToModel(response: Data?) -> UserRoot{
        do{
            let data = try JSONDecoder().decode(self, from: response!)
            return data
        }catch{
            return UserRoot()
        }
    }
    
    
    
    init() {
        self.getUser()
    }
    
    
    
 
    public func getUser(){
    
        
        self.result = User()
        self.access_token = UserDefaults.standard.string(forKey: "token")
        self.expires_in = UserDefaults.standard.integer(forKey: "expire")
        self.result?.id = UserDefaults.standard.integer(forKey: "id")
        self.result?.image = UserDefaults.standard.string(forKey: "image")
        self.result?.fname = UserDefaults.standard.string(forKey: "fname")
        self.result?.lname = UserDefaults.standard.string(forKey: "lname")
        self.result?.email = UserDefaults.standard.string(forKey: "email")
        self.result?.password = UserDefaults.standard.string(forKey: "password")
        self.result?.mobile = UserDefaults.standard.integer(forKey: "mobile")
    }
    public func storeInDefault() {
        let defaults = UserDefaults.standard
        if let _ = access_token{
            defaults.set(self.access_token , forKey: "token")
            defaults.set(self.expires_in, forKey: "expire")
        }
        guard let data = self.result else {return}
        
        defaults.set(true, forKey: "LOGIN")
        defaults.set(Date(), forKey: "LastLogin")
        defaults.set(data.email , forKey: "email")
        defaults.set(data.fname, forKey: "fname")
        defaults.set(data.lname, forKey: "lname")
        defaults.set(data.image, forKey: "image")
        defaults.set(data.mobile, forKey: "mobile")
        defaults.set(data.id, forKey: "id")
        defaults.set(data.password, forKey: "password")
        
    }
    public static func removeCacheingDefault() {
        UserDefaults.standard.removeObject(forKey: "LastLogin")
        UserDefaults.standard.removeObject(forKey: "LOGIN")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "image")
        UserDefaults.standard.removeObject(forKey: "fname")
        UserDefaults.standard.removeObject(forKey: "lname")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "mobile")
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "expire")
    }
    
}



class User : Decodable{
    
    var email : String?
    var fname : String?
    var id : Int?
    var image : String?
    var lname : String?
    var mobile : Int?
    var password : String?
    
    
    public static func convertToModel(response: Data?) -> User{
        do{
            let data = try JSONDecoder().decode(self, from: response!)
            return data
        }catch{
            return User()
        }
    }
    
    
}
