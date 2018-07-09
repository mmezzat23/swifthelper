
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

        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp).int
        //let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        let expiration = UserDefaults.standard.integer(forKey: "expire")
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

        if (UserRoot.instance.token != nil){
            if !Authorization.running{
                Authorization.running = true
                if !setupTimestamp(){
                    
                    ApiManager.instance.callGet(.token) { response in
                        Authorization.running = false
                        let data = TokenModel.convertToModel(response: response)
                        if let token = data.token{
                            let defaults = UserDefaults.standard
                            defaults.set(data.token! , forKey: "token")
                            defaults.set(data.expire!, forKey: "expire")
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
