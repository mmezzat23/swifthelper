
public func api(_ method:Apis , _ paramters:[Any] = [])->String {
    var url = method.rawValue
    for key in paramters{
        url = url+"/\(key)"
    }
    return url
    
}

extension BaseApi{
   
    func safeUrl(url:String) -> String {
        let safeURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        return safeURL
    }
    func initGet(method:String)-> String{
        
        var genericUrl:String = method
        var counter = 0
        
        if(self.paramaters.count > 0){
            for (key , value) in self.paramaters{
                
                
                if(counter == 0){
                    genericUrl = genericUrl+"?"+key+"=\(value)"
                }else{
                    genericUrl = genericUrl+"&"+key+"=\(value)"
                }
                counter += 1
            }
        }
        
        return genericUrl
    }
    
    func showAlert(message:String,indetifier:String = "")  {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        if(indetifier.isEmpty){
            let acceptAction = UIAlertAction(title: translate("ok"), style: .default) { (_) -> Void in
            }
            alert.addAction(acceptAction)
            
        }else{
            let acceptAction = UIAlertAction(title: translate("ok"), style: .default) { (_) -> Void in
                let storyboard: UIStoryboard = UIStoryboard(name: Constants.storyboard, bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: indetifier)
                
                UIApplication.topViewController()?.navigationController?.pushViewController(vc)
            }
            alert.addAction(acceptAction)
            
        }
        
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        
        
    }

   
    func setErrorMessage(data:Data?){
        guard let response = data else { return }
        let error = BaseModel.convertToModel(response: response)
        if let errors = error.errors{
            if let _ = error.message{
                errors.message = error.message
            }
            self.showAlert(message: errors.description())
        }else{
            if let _ = error.message{
                self.showAlert(message: error.message!)
            }
        }

    }
    
}
