
import CoreData
 
 class FacebookModel :Decodable{
    
    
    var id : String?
    var name : String?
    var email : String?
    var image:String?
    
    public static func convertToModel(response: Data?) -> FacebookModel{
        do{
            let data = try JSONDecoder().decode(self, from: response!)
            return data
        }catch{
            print("catch")
            return FacebookModel()
        }
    }
    func parseImage(dic:NSDictionary){
        let firstDic = dic["picture"]
        guard let secondDic = firstDic as? NSDictionary else { return }
        guard let data = secondDic["data"] as? NSDictionary else { return }
        guard let picture = data["url"] else { return }
        self.image = picture as? String
        
    }
    
 }
