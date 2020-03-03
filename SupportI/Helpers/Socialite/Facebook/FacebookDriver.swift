//
//import UIKit
//import FBSDKLoginKit
//import NVActivityIndicatorView
//
//
//typealias callbackFacebook = (FacebookModel)->()
//
//class FacebookDriver:SocialError,SocialIndicator{
//    var viewController:UIViewController!
//    init(delegate:UIViewController) {
//        viewController = delegate
//    }
//
//    // Once the button is clicked, show the login dialog
//    func checkFBlogin()->Bool{
//        if(FBSDKAccessToken.current() != nil){
//            return true
//        }else{
//            return false
//        }
//    }
//
//    //make login by fbsdk
//
//    func callback(completionHandler: @escaping callbackFacebook){
//        if(checkFBlogin()){
//            self.fetchUserProfile(){ facebook in
//                completionHandler(facebook)
//            }
//        }
//        else{
//            let loginManager = FBSDKLoginManager()
//
//            loginManager.logIn(withReadPermissions:[ "public_profile","email" ],from: viewController) { result,error  in
//                if(error != nil){
//                    self.alertError()
//                }
//                if let resultLogin = result {
//                    if resultLogin.isCancelled{
//                        self.alertError()
//                    }else{
//                        self.startLoading()
//                        self.fetchUserProfile(){ facebook in
//                            completionHandler(facebook)
//                        }
//                    }
//                }
//
//            }
//        }
//
//    }
//
//    //handler graph
//    func fetchUserProfile(completionHandler: @escaping callbackFacebook)
//    {
//
//        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, relationship_status ,
                        //email ,picture.width(480).height(480)"]).start(completionHandler: { (connection, result, error) -> Void in
//            self.stopLoading()
//            if (error == nil){
//
//                let fbDetails = result as! NSDictionary
//
//                do {
//                    print(result , fbDetails)
//                    let jsonData = try JSONSerialization.data(withJSONObject: fbDetails, options: .prettyPrinted)
//
//                    // here "jsonData" is the dictionary encoded in JSON data
//
//                    //let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
//
//                    // here "decoded" is of type `Any`, decoded from JSON data
//                    let facebook  = FacebookModel.convertToModel(response: jsonData)
//                    facebook.parseImage(dic: fbDetails)
//                    completionHandler(facebook)
//
//                } catch {
//                    self.alertError()
//                }
//
//
//
//
//            }else{
//                self.alertError()
//            }
//        })
//    }
//    //end
//}
//
