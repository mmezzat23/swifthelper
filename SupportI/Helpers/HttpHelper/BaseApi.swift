import Alamofire
import NVActivityIndicatorView

class BaseApi:Downloader,Paginator {
 
   
    
    let url = Constants.url
    var paramaters :[String:Any] = [:]
    var headers : [String:String] = [:]
    
    var running:Bool = false

    override init() {
        super.init()
        setupObject()
    }
    func refresh()  {
        setupObject()
        paginate()
    }
    func setupObject(){
        headers["version"] = Constants.version
        headers["lang"] = LocalizationHelper.getAppLang()
        if(UserDefaults.standard.bool(forKey: "LOGIN")){
            if let token = UserDefaults.standard.string(forKey: "token"){
                headers["Authorization"] = token
            }
        }
        
        paramaters["lang"] = LocalizationHelper.getAppLang()
        paramaters["device_type"] = Constants.deviceType
        if let devicetoken = UserDefaults.standard.string(forKey: "deviceToken"){
            paramaters["device_token"] = devicetoken
            
        }else{
            paramaters["device_token"] = "nil"
        }
        
    }
    func resetObject()  {
        self.paramaters = [:]
        setupObject()
    }
    
    func connection(_ method: String , type:HTTPMethod, completionHandler: @escaping (Data?) -> ()) {
        self.running = true
        
        var url = ""
        if type == .get{
            let methodFull = initGet(method: method)
            url = self.url+methodFull
        }else{
            url = self.url+method
        }
        
        print(url)
        Alamofire.request(safeUrl(url: url),method: type , parameters: self.paramaters , headers : self.headers)
            .responseJSON { response in
                
                print(response.result.value ?? "")
                self.running = false
                
                switch response.result {
                //case .success(let value)
                case .success:
                    
                    switch response.response?.statusCode{
                    case 200?:
                        completionHandler(response.data)
                    case 201?:
                        completionHandler(response.data)
                        
                    case 400?:
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        self.setErrorMessage(data: response.data)
                    //completionHandler(nil)
                    case 401?:
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        self.showAlert(message: translate("authorization"),indetifier: Constants.login)
                    case 422?:
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        self.setErrorMessage(data: response.data)
                    //completionHandler(nil)
                    case .none:
                        break
                    case .some(_):
                        break
                    }
                case .failure(let error):
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    self.showAlert(message: error.localizedDescription)
                    
                }
                
        }
    }
    
}
    

    
