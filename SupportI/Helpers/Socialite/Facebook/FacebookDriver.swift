
import UIKit
import FBSDKLoginKit

typealias CallbackFacebook = (FacebookModel) -> Void

class FacebookDriver: SocialError, SocialIndicator {
    weak var viewController: UIViewController!
    init(delegate: UIViewController) {
        viewController = delegate
    }

    // Once the button is clicked, show the login dialog
    func checkFBlogin() -> Bool {
        if(AccessToken.current != nil) {
            return true
        } else {
            return false
        }
    }

    //make login by fbsdk

    func callback(completionHandler: @escaping CallbackFacebook) {
        if checkFBlogin() {
            self.fetchUserProfile { facebook in
                completionHandler(facebook)
            }
        } else{
            let loginManager = LoginManager()

            loginManager.logIn(permissions: [ "public_profile","email" ],from: viewController) { result,error  in
                if(error != nil){
                    self.alertError()
                }
                if let resultLogin = result {
                    if resultLogin.isCancelled {
                        self.alertError()
                    } else {
                        self.startLoading()
                        self.fetchUserProfile { facebook in
                            completionHandler(facebook)
                        }
                    }
                }

            }
        }

    }

    //handler graph
    func fetchUserProfile(completionHandler: @escaping CallbackFacebook) {
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, relationship_status , email ,picture.width(480).height(480)"])
            .start(completionHandler: { (connection, result, error) -> Void in
            self.stopLoading()
            if (error == nil) {

                let fbDetails = result as! NSDictionary

                do {
                    print(result , fbDetails)
                    let jsonData = try JSONSerialization.data(withJSONObject: fbDetails, options: .prettyPrinted)

                    // here "jsonData" is the dictionary encoded in JSON data

                    //let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])

                    // here "decoded" is of type `Any`, decoded from JSON data
                    let facebook  = FacebookModel.convertToModel(response: jsonData)
                    facebook.parseImage(dic: fbDetails)
                    completionHandler(facebook)

                } catch {
                    self.alertError()
                }
            } else {
                self.alertError()
            }
        })
    }
    //end
}
