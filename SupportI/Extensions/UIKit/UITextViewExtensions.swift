//
//  UITextViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/28/16.
//  Copyright © 2016 SwifterSwift
//

import UIKit

#if !os(watchOS)
// MARK: - Methods
public extension UITextView {

	/// SwifterSwift: Clear text.
    func clear() {
		text = ""
		attributedText = NSAttributedString(string: "")
	}

	/// SwifterSwift: Scroll to the bottom of text view
    func scrollToBottom() {
        // swiftlint:disable next legacy_constructor
		let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
	}

	/// SwifterSwift: Scroll to the top of text view
    func scrollToTop() {
        // swiftlint:disable next legacy_constructor
		let range = NSMakeRange(0, 1)
		scrollRangeToVisible(range)
	}

    
}

fileprivate var textViewsHieght:[UITextView:NSLayoutConstraint] = [:]
extension UITextView {
    @IBInspectable public var viewHeight: Int {
        get {
            return self.viewHeight
        }
        set {
            self.setHieght(value: newValue)
        }
    }
    @IBInspectable public var autoHieght: Bool {
        get {
            return self.autoHieght
        }
        set {
            if newValue {
                self.runAutoHieght()
            }
        }
    }
    func setHieght(value:Int){
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: value.cgFloat)
        self.addConstraint(constraint)
        textViewsHieght[self] = constraint
    }
    
    func runAutoHieght(){
        self.delegate = self
        self.addBottomBorder(withColor: UIColor.colorRGB(red: 209, green: 209, blue: 209))
        
    }
    func getHieght()->NSLayoutConstraint?{
        if textViewsHieght[self] != nil {
            return textViewsHieght[self]
        }else{
            return nil
        }
    }
    
}

extension UITextView:UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        guard let textViewHeight = self.getHieght() else { return }
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame
        
        if newSize.height > textViewHeight.constant{
            textViewHeight.constant = newSize.height
        }
        if newSize.height < 40 {
            textViewHeight.constant = 40
        }
        
    }
    
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.lightGray
            guard let textViewHeight = self.getHieght() else { return }
            textViewHeight.constant = self.viewHeight.cgFloat
        }
    }
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}


#endif


