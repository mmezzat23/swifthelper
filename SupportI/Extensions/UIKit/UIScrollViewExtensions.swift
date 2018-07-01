import UIKit

/// scrolling at buttom true
///
/// - Returns: bool value

public func didEndDragging(item:UIScrollView)->Bool{
    if ((item.contentOffset.y + item.frame.size.height) >= item.contentSize.height)
    {
        return true
    }else{
        return false
    }
}
extension UIScrollView{
    /// scrolling at buttom true
    ///
    /// - Returns: bool value
    
    func didEndDragging()->Bool{
        if ((self.contentOffset.y + self.frame.size.height) >= self.contentSize.height)
        {
            return true
        }else{
            return false
        }
    }
}
