//
//  UILabelExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/23/16.
//  Copyright © 2016 SwifterSwift
//

import UIKit

#if !os(watchOS)
// MARK: - Methods

public extension UILabel {

	/// SwifterSwift: Initialize a UILabel with text
    convenience init(text: String?) {
		self.init()
		self.text = text
	}

	/// SwifterSwift: Required height for a label
    var requiredHeight: CGFloat {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.byWordWrapping
		label.font = font
		label.text = text
		label.attributedText = attributedText
		label.sizeToFit()
		return label.frame.height
	}
    
}

#endif
// MARK: - Methods
public extension UILabel {
    func setunderline(title:String){
        attributedString =  NSMutableAttributedString(string:"")
        let buttonTitleStr = NSMutableAttributedString(string:title.localized, attributes:attrs)
        attributedString.append(buttonTitleStr)
        attributedText = attributedString
    }
    private struct AssociatedKeys {
            static var padding = UIEdgeInsets()
        }

        public var padding: UIEdgeInsets? {
            get {
                return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
            }
            set {
                if let newValue = newValue {
                    objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
        }

        override open func draw(_ rect: CGRect) {
            if let insets = padding {self.drawText(in: rect.inset(by: insets))
            } else {
                self.drawText(in: rect)
            }
        }

        override open var intrinsicContentSize: CGSize {
            guard let text = self.text else { return super.intrinsicContentSize }

            var contentSize = super.intrinsicContentSize
            var textWidth: CGFloat = frame.size.width
            var insetsHeight: CGFloat = 0.0
            var insetsWidth: CGFloat = 0.0

            if let insets = padding {
                insetsWidth += insets.left + insets.right
                            insetsHeight += insets.top + insets.bottom
                            textWidth -= insetsWidth
                        }

                        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                        attributes: [NSAttributedString.Key.font: self.font], context: nil)

                        contentSize.height = ceil(newSize.size.height) + insetsHeight
                        contentSize.width = ceil(newSize.size.width) + insetsWidth

                        return contentSize
                    }
    
}
