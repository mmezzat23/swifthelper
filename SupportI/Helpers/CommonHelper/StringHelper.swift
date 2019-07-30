import UIKit

extension String {
    func splitString(_ string:String) -> String {
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
        
        let attributeString = NSMutableAttributedString(string: key,
                                                        attributes: yourAttributes)
        
        return attributeString
    }

}
