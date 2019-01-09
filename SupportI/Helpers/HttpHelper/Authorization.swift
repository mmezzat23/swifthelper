
class Authorization{
    struct Static {
        static var instance: Authorization?
    }
    
    class var instance : Authorization {
        
        if(Static.instance == nil) {
            Static.instance = Authorization()
        }
        
        return Static.instance!
    }
    
    
    static var running:Bool = false
    func setupTimestamp()->Bool {
        //return true
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp).int
        //let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        let expiration = UserDefaults.standard.integer(forKey: "expires_in")
//        if expiration > 0{
//            let time = NSDate(timeIntervalSince1970: TimeInterval(expiration))
//        }
        
        if expiration < myTimeInterval{
            return false
        }else{
            return true
        }
    }
    func refreshToken(_ completionHandler: @escaping (Bool) -> ()) {

        if (UserRoot.instance.refresh_token != nil){
            if !Authorization.running{
                Authorization.running = true
                if !setupTimestamp(){
                    
                    ApiManager.instance.paramaters["refresh_token"] = UserDefaults.standard.string(forKey: "refresh_token")
                    ApiManager.instance.connection(.token,type: .post) { response in
                        Authorization.running = false
                        
                        let data = TokenModel.convertToModel(response: response)
                        if data.access_token != nil{
                            let defaults = UserDefaults.standard
                            defaults.set(data.access_token! , forKey: "access_token")
                            defaults.set(data.expires_in!, forKey: "expires_in")
                            defaults.set(data.refresh_token!, forKey: "refresh_token")
                            completionHandler(true)
                        }else{
                            Authorization.running = false
                            completionHandler(false)
                        }
                        
                        
                    }
                }else{
                    Authorization.running = false
                    completionHandler(true)
                    
                }
            }else{
                Authorization.running = false
                completionHandler(true)
            }
            
        }else{
            completionHandler(true)
        }
        
    }
}
