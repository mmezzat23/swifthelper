 import CoreData
 import UIKit
 public func call(text:String?) {
    
    if var mobile = text{
        mobile = mobile.cut(charSplit: " ", charWith: "")
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
 public func shareApp(items:[Any] = []) {
    var sharing = items
    sharing.append(Constants.itunesURL)
    let activityVC = UIActivityViewController(activityItems: sharing, applicationActivities: nil)
    //New Excluded Activities Code
    activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
    //
    let view = UIApplication.topMostController()
    activityVC.popoverPresentationController?.sourceView = view.view
    view.present(activityVC, animated: true, completion: nil)
    
    
 }
 
 public func random(_ n:Int = 100) ->Int {
    return Int(arc4random_uniform(UInt32(n)))
 }
 public func randomNumbers(_ n:Int = 100)->Int{
    return random(n)
 }
 func randomString()->String{
    let timestamp = NSDate().timeIntervalSince1970
    return "\(TimeInterval(timestamp).int)-\(random(1000))"
 }
 
 func createActionSheet(title:String, actions:[String:Any] , closure:@escaping ([String:Any])->() ){
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
    for (key,value) in actions{
        alert.addAction(UIAlertAction(title: key, style: .default, handler: { _ in
            closure([key:value])
        }))
    }
    alert.addAction(UIAlertAction.init(title: translate("cancel"), style: .cancel, handler: nil))
    
    /*If you want work actionsheet on ipad
     then you have to use popoverPresentationController to present the actionsheet,
     otherwise app will crash on iPad */
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
        alert.popoverPresentationController?.permittedArrowDirections = .up
    default:
        break
    }
    UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
 }
 
 
 func errorAlert(_ message:String)  {
    
    let alert = UIAlertController(title: translate("alert"), message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    let cancelAction = UIAlertAction(title: translate("cancel"), style: .default) { (_) -> Void in
    }
    alert.addAction(cancelAction)
    UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    
    
 }
 func makeAlert(_ message:String, closure:@escaping ()->() )  {
    
    let alert = UIAlertController(title: translate("alert"), message: message, preferredStyle: UIAlertControllerStyle.alert)
    let acceptAction = UIAlertAction(title: translate("sure"), style: .default) { (_) -> Void in
        closure()
    }
    let cancelAction = UIAlertAction(title: translate("cancel"), style: .default) { (_) -> Void in
    }
    alert.addAction(acceptAction)
    alert.addAction(cancelAction)
    UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    
    
 }
