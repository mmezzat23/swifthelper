import Alamofire

class BaseApi: Downloader, Paginator, Alertable {
    let url = Constants.url
    var paramaters: [String: Any] = [:]
    var headers: [String: String] = [:]
    var isHttpRequestRun: Bool = false

    override init() {
        super.init()
        setupObject()
    }
    func refresh() {
        setupObject()
        paginate()
    }
    func setupObject() {
        headers["version"] = Constants.version
        headers["Device"] = Constants.deviceId
        headers["lang"] = Localizer.current
        if let token = UserRoot.token() {
            headers["Authorization"] =  "Bearer "+token
        }
        else {
            headers["Authorization"] = "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IkMyMjRGNzI4Q0JDQjgxQzlEM0FEOEM4RDM4NDk0RDNDIiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2MzQxNTYxOTMsImV4cCI6MTk0OTUxNjE5MywiaXNzIjoiaHR0cHM6Ly93bmRvLm5ldDo1MDAwIiwiYXVkIjoiV25kb0FwcCIsImNsaWVudF9pZCI6IlduZG9BcHBfVG9rZW4iLCJzdWIiOiJiMGNjZmYyMy1mNGQzLWMwMWItMTY1OC0zOWZmOGIzNjVlY2QiLCJhdXRoX3RpbWUiOjE2MzQxNTYxOTMsImlkcCI6ImxvY2FsIiwicm9sZSI6ImFkbWluIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiRmFsc2UiLCJlbWFpbCI6ImFkbWluQGFicC5pbyIsImVtYWlsX3ZlcmlmaWVkIjoiRmFsc2UiLCJuYW1lIjoiYWRtaW4iLCJpYXQiOjE2MzQxNTYxOTMsInNjb3BlIjpbIlduZG9BcHAiXSwiYW1yIjpbInB3ZCJdfQ.j38j8S8V8lHT2-fA1Sr8O_Dcvz8Y_UnG66qbnJ2Tc--iuTm3Mxwhmnnmr9QCCY3hG_eHxjGm2XkeVewm7g6utX8cZwCwhu10pLt3yfkJp-h74KWo8jXrb3shbcATwmrPn5OzHlHh28NmuJ01kZnGNY9T7YfKGEHAXos9wFGDN3SmrsK1S8tFl2m0aeIpgpvw1GuzMYzmNZ4Odh71zVsUYHn-pfjg172sAfDZ4OCtZuzLdGV-7zrUjWXg_s0pEl2qoHNG5h_W4rcVJSnvdVgqQ_ThwyW2IQ9eKr7IWBAjc2wTwGnUsZCSri_6Nk-IakrMlSGYTfAPjBojOO8AgJ8VwA"
            
        }
        
//        if UserDefaults.standard.bool(forKey: "LOGIN") {
//            if let token = UserDefaults.standard.string(forKey: "access_token") {
//                headers["Authorization"] = "Bearer "+token
//            } else {
//                headers["Authorization"] = "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IkMyMjRGNzI4Q0JDQjgxQzlEM0FEOEM4RDM4NDk0RDNDIiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2MzE2MzE5NzYsImV4cCI6MTk0Njk5MTk3NiwiaXNzIjoiaHR0cHM6Ly93bmRvLm5ldDo1MDAwIiwiYXVkIjoiV25kb0FwcCIsImNsaWVudF9pZCI6IlduZG9BcHBfVG9rZW4iLCJzdWIiOiJmZDA1NGNmMi01NjE1LTljNjQtZDBlYy0zOWZlZjZmOWI0MDEiLCJhdXRoX3RpbWUiOjE2MzE2MzE5NzUsImlkcCI6ImxvY2FsIiwicm9sZSI6ImFkbWluIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiRmFsc2UiLCJlbWFpbCI6ImFkbWluQGFicC5pbyIsImVtYWlsX3ZlcmlmaWVkIjoiRmFsc2UiLCJuYW1lIjoiYWRtaW4iLCJpYXQiOjE2MzE2MzE5NzYsInNjb3BlIjpbIlduZG9BcHAiLCJvZmZsaW5lX2FjY2VzcyJdLCJhbXIiOlsicHdkIl19.qwhi4QLiwL5nFIhzTYjasP5FnhGkUhVbpd0h-kMDEBTQRXX7No84Ibx4TQbAPrID8gwIIMl1ZU9D1Qnj4fQESxCuAL1ofI9koboIwKTFH1G0M5jZYUFnwSQ6JYAugcoltC_0xjWQDr2pBuzPYSwBc7AI4ja4wsDJLLK9hqWD7YEm-TpuXVse6AEHfxAXspeYCSu3RVMlOx66PrN3f5i00J7X_YlppwCGvRMfGO0k8Q2y0fnD0IxmFE6RzOVGB6JsE9ZX3w-JCv-dcbN7NJ9kQeKHLN0BgHjYYVGcEZDtuViu_s78Au0XvPA0t5-I_0x1xX6ndkZ3viOGmz2VXA7yRQ"
//            }
//        }else {
//            headers["Authorization"] = "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IkMyMjRGNzI4Q0JDQjgxQzlEM0FEOEM4RDM4NDk0RDNDIiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2MzE2MzE5NzYsImV4cCI6MTk0Njk5MTk3NiwiaXNzIjoiaHR0cHM6Ly93bmRvLm5ldDo1MDAwIiwiYXVkIjoiV25kb0FwcCIsImNsaWVudF9pZCI6IlduZG9BcHBfVG9rZW4iLCJzdWIiOiJmZDA1NGNmMi01NjE1LTljNjQtZDBlYy0zOWZlZjZmOWI0MDEiLCJhdXRoX3RpbWUiOjE2MzE2MzE5NzUsImlkcCI6ImxvY2FsIiwicm9sZSI6ImFkbWluIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiRmFsc2UiLCJlbWFpbCI6ImFkbWluQGFicC5pbyIsImVtYWlsX3ZlcmlmaWVkIjoiRmFsc2UiLCJuYW1lIjoiYWRtaW4iLCJpYXQiOjE2MzE2MzE5NzYsInNjb3BlIjpbIlduZG9BcHAiLCJvZmZsaW5lX2FjY2VzcyJdLCJhbXIiOlsicHdkIl19.qwhi4QLiwL5nFIhzTYjasP5FnhGkUhVbpd0h-kMDEBTQRXX7No84Ibx4TQbAPrID8gwIIMl1ZU9D1Qnj4fQESxCuAL1ofI9koboIwKTFH1G0M5jZYUFnwSQ6JYAugcoltC_0xjWQDr2pBuzPYSwBc7AI4ja4wsDJLLK9hqWD7YEm-TpuXVse6AEHfxAXspeYCSu3RVMlOx66PrN3f5i00J7X_YlppwCGvRMfGO0k8Q2y0fnD0IxmFE6RzOVGB6JsE9ZX3w-JCv-dcbN7NJ9kQeKHLN0BgHjYYVGcEZDtuViu_s78Au0XvPA0t5-I_0x1xX6ndkZ3viOGmz2VXA7yRQ"
//        }
        paramaters["client_id"] = "WndoApp_App"
        paramaters["client_secret"] = "1q2w3e*"
        headers["lang"] = Localizer.current
        paramaters["device_type"] = Constants.deviceType
        if let devicetoken = UserDefaults.standard.string(forKey: "deviceToken") {
            paramaters["device_token"] = devicetoken
        } else {
            paramaters["device_token"] = "nil"
        }
//        paramaters["device_id"] = Constants.deviceId

    }
    func resetObject() {
        self.paramaters = [:]
        setupObject()
    }
    func initURL(method: String, type: HTTPMethod) -> String {
        var url = ""
        if type == .get {
            let methodFull = initGet(method: method)
            url = self.url+methodFull
        } else {
            url = self.url+method
        }
        return url
    }
    func connection(_ method: String, type: HTTPMethod,
                    completionHandler: @escaping (Data?) -> Void) {
        self.isHttpRequestRun = true
        let url = initURL(method: method, type: type)
        print(url)
        let paramters = self.paramaters
        self.resetObject()
        Alamofire.request(safeUrl(url: url), method: type, parameters: paramters, headers: self.headers)
            .responseJSON { response in
                print(response.result.value ?? "")
                print(response.response?.statusCode ?? 0)
                self.isHttpRequestRun = false
//                switch response.result {
//                //case .success(let value)
//                case .success:
                    switch response.response?.statusCode {
                    case 200?:
                        completionHandler(response.data)
                    case 201?:
                        completionHandler(response.data)

                    case 400?:
                        if (url.contains("connect/token")){
                            UserRoot.savesaller(remember: false)
                            UserRoot.save(response: Data())
                            guard let vcr = Constants.loginNav else { return }
                            let appDelegate = UIApplication.shared.delegate as? AppDelegate
                            appDelegate?.window?.rootViewController = vcr

                        }else{
                            UIApplication.topViewController()?.stopLoading()
                            self.setErrorMessage(data: response.data)
                        }
                        
                    //completionHandler(nil)
                    case 401?:
                        UserRoot.save(response: Data())
                        UserRoot.savesaller(remember: false)
                        guard let vcr = Constants.loginNav else { return }
                        let appDelegate = UIApplication.shared.delegate as? AppDelegate
                        appDelegate?.window?.rootViewController = vcr

                    case 404?:
                        UIApplication.topViewController()?.stopLoading()
                        self.makeAlert("not_found.lan".localized, closure: {})
                    case 422?:
                        UIApplication.topViewController()?.stopLoading()
                        self.setErrorMessage(data: response.data)
                    //completionHandler(nil)
                    case .none:
                        break
                    case .some(let error):
                        UIApplication.topViewController()?.stopLoading()
                        self.makeAlert(error.string, closure: {})
                    }
//                case .failure(let error):
//                    UIApplication.topViewController()?.stopLoading()
//                    self.makeAlert(error.localizedDescription, closure: {})
//                }
        }
    }
    func connectionRaw(_ method: String, type: HTTPMethod,
                        completionHandler: @escaping (Data?) -> Void) {
            self.isHttpRequestRun = true
            
            let url = initURL(method: method, type: type)
            print(url)
            let paramters = self.paramaters
            self.resetObject()
            //        if (self.paramater1 == ""){
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 30
            manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            var request = URLRequest(url: URL(string: safeUrl(url: url))!)
            do {
                let data = try JSONSerialization.data(withJSONObject: paramters, options: [])
                let paramString = String(data: data, encoding: String.Encoding.utf8)
                request.httpBody = paramString?.data(using: .utf8)
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
            headers["Content-Type"] =  "application/json"
            request.httpMethod = type.rawValue
            request.allHTTPHeaderFields = headers
            request.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled

            Alamofire.request(request)
                .responseJSON { response in
                    print(response.result.value ?? "")
                    self.isHttpRequestRun = false
//                    switch response.result {
//                        //case .success(let value)
//                        case .success:
                            switch response.response?.statusCode {
                                case 200?:
                                    completionHandler(response.data)
                                case 201?:
                                    completionHandler(response.data)
                                
                                case 400?:
                                    UIApplication.topViewController()?.stopLoading()
                                    self.setErrorMessage(data: response.data)
                                //completionHandler(nil)
                                case 401?:
                                guard let vcr = Constants.loginNav else { return }
                                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                                appDelegate?.window?.rootViewController = vcr
//                                    if (url.contains("connect/token")){
//                                        UIApplication.topViewController()?.stopLoading()
//                                        self.makeAlert("the_login_is_required.lan".localized, closure: {
//                                            guard let vcr = Constants.loginNav else { return }
//                                            UIApplication.topMostController().navigationController?.pushViewController(vcr, animated: true)
//                                        })
//                                    }else{
//                                        UIApplication.topViewController()?.stopLoading()
//                                        self.setErrorMessage(data: response.data)
//                                    }
                                case 404?:
                                    UIApplication.topViewController()?.stopLoading()
                                    self.makeAlert("not_found.lan".localized, closure: {})
                                case 422?:
                                    UIApplication.topViewController()?.stopLoading()
                                    self.setErrorMessage(data: response.data)
                                //completionHandler(nil)
                                case .none:
                                    break
                                case .some(let error):
                                    UIApplication.topViewController()?.stopLoading()
                                    self.makeAlert(error.string, closure: {})
                        }
//                        case .failure(let error):
//                            UIApplication.topViewController()?.stopLoading()
//                            self.makeAlert(error.localizedDescription, closure: {})
//                    }
            }
    }
    func uploadFile(_ method: String , type: HTTPMethod, file: [[String: URL?]], completionHandler: @escaping (Data?) -> ()) {
        
        self.isHttpRequestRun = true
        
        let url = self.url+method
        setupObject()
        let paramters = self.paramaters
        self.resetObject()
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            file.forEach { (fileDic) in
                fileDic.forEach { (dic) in
                    if let url = dic.value {
                        print(url)
                        multipartFormData.append(url, withName: dic.key)
                    }
                }
            }
            
            for (key, value) in paramters {
                if let string = value as? Int {
                    multipartFormData.append(string.string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else if let string = value as? Double {
                    multipartFormData.append(string.string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else if let string = value as? String {
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                }
            } //Optional for extra parameters
        },to: url, headers: headers) { (result) in
            switch result {
                case .success(let upload, _, _):
//                    self.presenting()
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress: \(progress.fractionCompleted)")
//                        self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
//                        var progress = self.progressView.progress
//                        progress = progress*100
//                        self.label.text = "\(Int(progress))"+"%"
//                    })
                    
                    upload.responseJSON { response in
//                        self.restore()
                        self.isHttpRequestRun = false
                        print(response.result.value ?? "")
                        switch response.result {
                            //case .success(let value)
                            case .success:
                                
                                switch response.response?.statusCode {
                                    case 200?:
                                        completionHandler(response.data)
                                    case 201?:
                                        completionHandler(response.data)
                                    
                                    case 400?:
                                        UIApplication.topViewController()?.stopLoading()
                                        self.setErrorMessage(data: response.data)
                                    //completionHandler(nil)
                                    case 401?:
                                        UIApplication.topViewController()?.stopLoading()
                                        self.makeAlert("the_login_is_required.lan".localized, closure: {
                                            guard let nav = Constants.loginNav else { return }
                                            let delegate = UIApplication.shared.delegate as? AppDelegate
                                            delegate?.window?.rootViewController = nav
                                            
                                        })
                                    case 404?:
                                        UIApplication.topViewController()?.stopLoading()
                                        let data = try? JSONDecoder().decode(BaseModel.self, from: response.data ?? Data())
                                        if data?.message != nil {
                                            self.makeAlert(data?.message ?? "", closure: {})
                                        } else {
                                            self.makeAlert("not_found.lan".localized, closure: {})
                                    }
                                    case 422?:
                                        UIApplication.topViewController()?.stopLoading()
                                        self.setErrorMessage(data: response.data)
                                    //completionHandler(nil)
                                    case .none:
                                        break
                                    case .some(let error):
                                        UIApplication.topViewController()?.stopLoading()
                                        self.makeAlert(String(error), closure: {})
                            }
                            case .failure(let error):
                                UIApplication.topViewController()?.stopLoading()
                                self.makeAlert(error.localizedDescription, closure: {})
                        }
                }
                
                case .failure(let encodingError):
                    print(encodingError)
                    UIApplication.topViewController()?.stopLoading()
                    self.makeAlert(encodingError.localizedDescription, closure: {})
            }
        }
    }
    func uploadMultiFiles(_ method: String , type: HTTPMethod, files: [UIImage], key: String, file: [String: URL?]? = nil, completionHandler: @escaping (Data?) -> ()) {
        
        self.isHttpRequestRun = true
        
        let url = self.url+method
        let paramters = self.paramaters
        self.resetObject()
        print(paramaters)
        Alamofire.upload(multipartFormData: { multipartFormData in
            var counter = 0
            for item in files {
                //multipartFormData.append(item, withName: "\(key)[\(counter)]")
                multipartFormData.append(item.jpegData(compressionQuality: 0.5) ?? Data(), withName: "\(key)[\(counter)]", fileName: "\(String.random(ofLength: 15)).jpg", mimeType: "image/jpeg")
                counter += 1
            }
            //            files.forEach({ (item) in
            //
            //            })
            if file != nil {
                file?.forEach({ (fileData) in
                    if let url = fileData.value {
                        multipartFormData.append(url, withName: "\(fileData.key)")
                    }
                })
            }
            for (key, value) in paramters {
                if let id = value as? Int {
                    let string = id.string
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else if let id = value as? Double {
                    let string = id.string
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else {
                    let string = value as? String
                    multipartFormData.append(string?.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                }
                
            } //Optional for extra parameters
        },to: url, headers: headers) { (result) in
            switch result {
                case .success(let upload, _, _):
                    self.presenting()
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                        self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
                        var progress = self.progressView.progress
                        progress = (progress * 100)
                        self.label.text = "\(Int(progress))"+"%"
                    })
                    
                    upload.responseJSON { response in
                        self.restore()
                        self.isHttpRequestRun = false
                        print(response.result.value ?? "")
                        switch response.result {
                            //case .success(let value)
                            //case .success(let value)
                            case .success:
                                switch response.response?.statusCode {
                                    case 200?:
                                        completionHandler(response.data)
                                    case 201?:
                                        completionHandler(response.data)
                                    
                                    case 400?:
                                        UIApplication.topViewController()?.stopLoading()
                                        self.setErrorMessage(data: response.data)
                                    //completionHandler(nil)
                                    case 401?:
                                        UIApplication.topViewController()?.stopLoading()
                                        self.makeAlert("the_login_is_required.lan".localized, closure: {
                                            guard let nav = Constants.loginNav else { return }
                                            let delegate = UIApplication.shared.delegate as? AppDelegate
                                            delegate?.window?.rootViewController = nav
                                            
                                        })
                                    case 404?:
                                        UIApplication.topViewController()?.stopLoading()
                                        let data = try? JSONDecoder().decode(BaseModel.self, from: response.data ?? Data())
                                        if data?.message != nil {
                                            self.makeAlert(data?.message ?? "", closure: {})
                                        } else {
                                            self.makeAlert("not_found.lan".localized, closure: {})
                                    }
                                    case 422?:
                                        UIApplication.topViewController()?.stopLoading()
                                        self.setErrorMessage(data: response.data)
                                    //completionHandler(nil)
                                    case .none:
                                        break
                                    case .some(let error):
                                        UIApplication.topViewController()?.stopLoading()
                                        self.makeAlert(String(error), closure: {})
                            }
                            case .failure(let error):
                                UIApplication.topViewController()?.stopLoading()
                                self.makeAlert(error.localizedDescription, closure: {})
                        }
                }
                
                case .failure(let encodingError):
                    print(encodingError)
                    UIApplication.topViewController()?.stopLoading()
                    self.makeAlert(encodingError.localizedDescription, closure: {})
            }
        }
    }
    
}
