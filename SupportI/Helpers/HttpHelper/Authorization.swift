import CoreData

class Authorization {
    struct Static {
        static var instance: Authorization?
    }
    class var instance: Authorization {
        if Static.instance == nil {
            Static.instance = Authorization()
        }
        return Static.instance!
    }
    static var running: Bool = false
    func setupTimestamp() -> Bool {
        //return true
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp).int
        var expiration = UserDefaults.standard.integer(forKey: "expires_in")
        let loginTimeStamp = UserDefaults.standard.integer(forKey: "LOGIN_TIMESTAMP")
        expiration += loginTimeStamp
//        if expiration > 0{
//            let time = NSDate(timeIntervalSince1970: TimeInterval(expiration))
//        }
        if expiration < myTimeInterval {
            return false
        } else {
            return true
        }
    }
    func refreshToken(_ completionHandler: @escaping (Bool) -> Void) {

        if UserRoot.fetch()?.responseData?.refresh_Token != nil {
            if !Authorization.running {
                Authorization.running = true
                if !setupTimestamp() {
                    ApiManager.instance.paramaters["refresh_token"] = UserRoot.fetch()?.responseData?.refresh_Token
                    ApiManager.instance.paramaters["grant_type"] = "refresh_token"
                    ApiManager.instance.connection(.token, type: .post) { response in
                        Authorization.running = false
                        guard let data = try? JSONDecoder().decode(TokenModel.self, from: response ?? Data()) else { return }
                        if data.access_token != nil {
                            let defaults = UserDefaults.standard
                            defaults.set(data.access_token!, forKey: "access_token")
                            defaults.set(data.expires_in!, forKey: "expires_in")
                            defaults.set(data.refresh_token!, forKey: "refresh_token")
                            completionHandler(true)
                        } else {
                            Authorization.running = false
                            completionHandler(false)
                        }
                    }
                } else {
                    Authorization.running = false
                    completionHandler(true)
                }
            } else {
                Authorization.running = false
                completionHandler(true)
            }
        } else {
            completionHandler(true)
        }

    }
    
    func refreshToken1(_ completionHandler: @escaping (Bool) -> Void) {

        if UserRoot.fetch()?.responseData?.refresh_Token != nil {
            if !Authorization.running {
                Authorization.running = true
                    ApiManager.instance.paramaters["refresh_token"] = UserRoot.fetch()?.responseData?.refresh_Token
                print(UserRoot.fetch()?.responseData?.refresh_Token)
                    ApiManager.instance.paramaters["grant_type"] = "refresh_token"
                ApiManager.instance.paramaters["client_id"] = "WndoApp_App"
                ApiManager.instance.paramaters["client_secret"] = "1q2w3e*"
                    ApiManager.instance.connection(.token, type: .post) { response in
                        Authorization.running = false
                        guard let data = try? JSONDecoder().decode(TokenModel.self, from: response ?? Data()) else { return }
                        if data.access_token != nil {
                            let defaults = UserDefaults.standard
                            defaults.set(data.access_token!, forKey: "access_token")
                            defaults.set(data.expires_in!, forKey: "expires_in")
                            defaults.set(data.refresh_token!, forKey: "refresh_token")
                            completionHandler(true)
                        } else {
                            Authorization.running = false
                            completionHandler(false)
                        }
                    }
               
            } else {
                Authorization.running = false
                completionHandler(true)
            }
        } else {
            completionHandler(true)
        }

    }
}
