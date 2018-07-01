import UIKit

func splitString(_ string:String)->String{
    var filter = string
    if let index = filter.range(of: " ")?.lowerBound {
        let spaceing = filter[..<index]
        let filterSpacing = String(spaceing)
        if(!filterSpacing.isEmpty){
            filter = filterSpacing
        }
    }
    //filter = filter.uppercased()
    print(filter)
    return filter
}

func stroke(key:String?)->NSAttributedString{
    
    guard let string = key else {return NSMutableAttributedString(string: "")}
    let attributes: NSMutableAttributedString =  NSMutableAttributedString(string: string)
    attributes.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributes.length))
    return attributes
}

func strokeUnderline(key:String , fontSize:Int = 16) ->NSAttributedString {
    let yourAttributes : [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.font : UIFont.systemFont(ofSize: CGFloat(fontSize)),
        NSAttributedStringKey.foregroundColor : Constants.mainColorRGB,
        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
    
    let attributeString = NSMutableAttributedString(string: translate(key),
                                                    attributes: yourAttributes)
    
    return attributeString
}

extension String{
    
    func splitString()->String{
        var filter = self
        if let index = filter.range(of: " ")?.lowerBound {
            let spaceing = filter[..<index]
            let filterSpacing = String(spaceing)
            if(!filterSpacing.isEmpty){
                filter = filterSpacing
            }
        }
        //filter = filter.uppercased()
        print(filter)
        return filter
    }
    
    func stroke()->NSAttributedString{
        let attributes: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributes.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributes.length))
        return attributes
    }
    func strokeUnderline(fontSize:Int = 16) ->NSAttributedString {
        let attributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: CGFloat(fontSize)),
            NSAttributedStringKey.foregroundColor : Constants.mainColorRGB,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
        
        let attributeString = NSMutableAttributedString(string: self, attributes: attributes)
        
        return attributeString
    }
    func getSize()->CGSize{
        let text = NSAttributedString(string:self)
        return text.size()
        
    }
}


