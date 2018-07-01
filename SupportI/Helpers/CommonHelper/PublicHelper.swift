 
 public func call(text:String?) {
    
    if let mobile = text{
        guard let number = URL(string: "tel://" + mobile) else { return }
        UIApplication.shared.open(number)
    }else{
        return
    }
    
 }
 public func sms(text:String?) {
    
    if let mobile = text{
        guard let number = URL(string: "sms://" + mobile) else { return }
        UIApplication.shared.open(number)
    }else{
        return
    }
    
 }
 public func sendSms(text:String?) {
    sms(text: text)
 }
 public func phoneCall(text:String?) {
    call(text: text)
 }
 public func sendMail(text:String?) {
    if let email = text{
        let string = "mailto:"+email
        if let url = URL(string: string) {
            UIApplication.shared.open(url)
        }
    }else{
        return
    }
 }
 public func openUrl(text:String?) {
    if let url = text{
        let url = URL(string: url)!
        UIApplication.shared.open(url)
    }else{
        return
    }
 }
 
 public func shareApp(url:String?) {
    let textToShare = translate("shareApp")
    if let urlString = url{
        if let myWebsite = NSURL(string: urlString) {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            //
            
            let view = UIApplication.topMostController()
            
            activityVC.popoverPresentationController?.sourceView = view.view
            view.present(activityVC, animated: true, completion: nil)
        }
        
    }else{
        return
    }
    
    
 }
 
 public func random(_ n:Int = 100)->Int{
    return Int(arc4random_uniform(UInt32(n)))
 }
 public func randomNumbers(_ n:Int = 100)->Int{
    return random(n)
 }
 func randomString()->String{
    let timestamp = NSDate().timeIntervalSince1970
    return "\(TimeInterval(timestamp).int)-\(random(1000))"
 }
