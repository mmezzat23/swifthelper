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
        if UserDefaults.standard.bool(forKey: "LOGIN") {
            if let token = UserDefaults.standard.string(forKey: "access_token") {
                headers["Authorization"] = "Bearer "+token
            } else {
                headers["Authorization"] = "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IkMyMjRGNzI4Q0JDQjgxQzlEM0FEOEM4RDM4NDk0RDNDIiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2MzE2MDk4ODYsImV4cCI6MTY2MzE0NTg4NiwiaXNzIjoiaHR0cHM6Ly93bmRvLm5ldDo1MDAwIiwiYXVkIjoiV25kb0FwcCIsImNsaWVudF9pZCI6IlduZG9BcHBfVG9rZW4iLCJzdWIiOiI3MmE4ZDAyYy1jZDc4LWFhNjktZjA0OC0zOWZlZjBhY2NjZDAiLCJhdXRoX3RpbWUiOjE2MzE2MDk4ODYsImlkcCI6ImxvY2FsIiwicm9sZSI6ImFkbWluIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiRmFsc2UiLCJlbWFpbCI6ImFkbWluQGFicC5pbyIsImVtYWlsX3ZlcmlmaWVkIjoiRmFsc2UiLCJuYW1lIjoiYWRtaW4iLCJpYXQiOjE2MzE2MDk4ODYsInNjb3BlIjpbIlduZG9BcHAiXSwiYW1yIjpbInB3ZCJdfQ.hmOLEvZ5ldTO-elIi1YM5ZVC_2SjSObFBRtYNa7mmPyCJtcaRI0ABpyH8q10S4J4nzZWPEtBbOVOeHAg947kr1qJFWH4lwlrsKwrVRRbLqCgZNwjhUaCFIs-DldDr38dSLRO1JEhKHVGwq8AfDrfu1vAfYEeUxSnQi3i7p21_Y7Rx4BKOKY0n3ybMufrQvZffjRIIpFSIzYbjNysQn2Y7JLvx_QeRGqe8IBMqNJCaDeNIfIWPaDuE8qeHB2gcyHR2OTFqUEL0Uqx-_7xTWtlaMDEK3guVkZ9NwhB2QMxU13gjbYhuQVAbSqHSD4G2BwSAza9E4TLKs0sUklibDsBfA"
            }
        }else {
            headers["Authorization"] = "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IkMyMjRGNzI4Q0JDQjgxQzlEM0FEOEM4RDM4NDk0RDNDIiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2MzE2MDk4ODYsImV4cCI6MTY2MzE0NTg4NiwiaXNzIjoiaHR0cHM6Ly93bmRvLm5ldDo1MDAwIiwiYXVkIjoiV25kb0FwcCIsImNsaWVudF9pZCI6IlduZG9BcHBfVG9rZW4iLCJzdWIiOiI3MmE4ZDAyYy1jZDc4LWFhNjktZjA0OC0zOWZlZjBhY2NjZDAiLCJhdXRoX3RpbWUiOjE2MzE2MDk4ODYsImlkcCI6ImxvY2FsIiwicm9sZSI6ImFkbWluIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiRmFsc2UiLCJlbWFpbCI6ImFkbWluQGFicC5pbyIsImVtYWlsX3ZlcmlmaWVkIjoiRmFsc2UiLCJuYW1lIjoiYWRtaW4iLCJpYXQiOjE2MzE2MDk4ODYsInNjb3BlIjpbIlduZG9BcHAiXSwiYW1yIjpbInB3ZCJdfQ.hmOLEvZ5ldTO-elIi1YM5ZVC_2SjSObFBRtYNa7mmPyCJtcaRI0ABpyH8q10S4J4nzZWPEtBbOVOeHAg947kr1qJFWH4lwlrsKwrVRRbLqCgZNwjhUaCFIs-DldDr38dSLRO1JEhKHVGwq8AfDrfu1vAfYEeUxSnQi3i7p21_Y7Rx4BKOKY0n3ybMufrQvZffjRIIpFSIzYbjNysQn2Y7JLvx_QeRGqe8IBMqNJCaDeNIfIWPaDuE8qeHB2gcyHR2OTFqUEL0Uqx-_7xTWtlaMDEK3guVkZ9NwhB2QMxU13gjbYhuQVAbSqHSD4G2BwSAza9E4TLKs0sUklibDsBfA"
        }
        paramaters["client_id"] = "WndoApp_App"
        paramaters["client_secret"] = "1q2w3e*"
        paramaters["lang"] = Localizer.current
        paramaters["device_type"] = Constants.deviceType
        if let devicetoken = UserDefaults.standard.string(forKey: "deviceToken") {
            paramaters["device_token"] = devicetoken
        } else {
            paramaters["device_token"] = "nil"
        }
        paramaters["device_id"] = Constants.deviceId

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
                switch response.result {
                //case .success(let value)
                case .success:
                    switch response.response?.statusCode {
                    case 200?:
                        completionHandler(response.data)
                    case 201?:
                        completionHandler(response.data)

                    case 400?:
                        if (url.contains("connect/token")){
                            UIApplication.topViewController()?.stopLoading()
                            self.makeAlert("the_login_is_required.lan".localized, closure: {
                                guard let vcr = Constants.loginNav else { return }
                                UIApplication.topMostController().navigationController?.pushViewController(vcr, animated: true)
                            })
                        }else{
                            UIApplication.topViewController()?.stopLoading()
                            self.setErrorMessage(data: response.data)
                        }
                        
                    //completionHandler(nil)
                    case 401?:
                        UIApplication.topViewController()?.stopLoading()
                        self.makeAlert("the_login_is_required.lan".localized, closure: {
                            guard let vcr = Constants.loginNav else { return }
                            UIApplication.topMostController().navigationController?.pushViewController(vcr, animated: true)
                        })
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
                case .failure(let error):
                    UIApplication.topViewController()?.stopLoading()
                    self.makeAlert(error.localizedDescription, closure: {})
                }
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
                                    if (url.contains("connect/token")){
                                        UIApplication.topViewController()?.stopLoading()
                                        self.makeAlert("the_login_is_required.lan".localized, closure: {
                                            guard let vcr = Constants.loginNav else { return }
                                            UIApplication.topMostController().navigationController?.pushViewController(vcr, animated: true)
                                        })
                                    }else{
                                        UIApplication.topViewController()?.stopLoading()
                                        self.setErrorMessage(data: response.data)
                                    }
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
                        case .failure(let error):
                            UIApplication.topViewController()?.stopLoading()
                            self.makeAlert(error.localizedDescription, closure: {})
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
