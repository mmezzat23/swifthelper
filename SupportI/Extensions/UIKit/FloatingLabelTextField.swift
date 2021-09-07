import UIKit
@IBDesignable class FloatLabelTextField: UITextField {
    let animationDuration = 0.3
    var title = UILabel()
    override var accessibilityLabel: String? {
        get {
            if let txt = text, txt.isEmpty {
                return title.text
            } else {
                return text
            }
        }
        set {
            self.accessibilityLabel = newValue
        }
    }
    override var placeholder: String? {
        didSet {
            title.text = placeholder
            title.sizeToFit()
        }
    }
    override var attributedPlaceholder: NSAttributedString? {
        didSet {
            title.text = attributedPlaceholder?.string
            title.sizeToFit()
        }
    }
    var titleFont: UIFont = UIFont.systemFont(ofSize: 12.0) {
        didSet {
            title.font = titleFont
            title.sizeToFit()
        }
    }
    @IBInspectable var hintYPadding: CGFloat = 0.0
    @IBInspectable var titleYPadding: CGFloat = 0.0 {
        didSet {
            var rem = title.frame
            rem.origin.y = titleYPadding
            title.frame = rem
        }
    }
    @IBInspectable var titleTextColour: UIColor = UIColor.gray {
        didSet {
            if !isFirstResponder {
                title.textColor = titleTextColour
            }
        }
    }
    @IBInspectable var titleActiveTextColour: UIColor! {
        didSet {
            if isFirstResponder {
                title.textColor = titleActiveTextColour
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder
        if let txt = text, !txt.isEmpty && isResp {
            title.textColor = titleActiveTextColour
        } else {
            title.textColor = titleTextColour
        }
        // Should we show or hide the title label?
        if let txt = text, txt.isEmpty {
            // Hide
            hideTitle(isResp)
        } else {
            // Show
            showTitle(isResp)
        }
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var frame = super.textRect(forBounds: bounds)
        if let txt = text, !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            frame = frame.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return frame.integral
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var frame = super.editingRect(forBounds: bounds)
        if let txt = text, !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            frame = frame.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return frame.integral
    }
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var frame = super.clearButtonRect(forBounds: bounds)
        if let txt = text, !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            frame = CGRect(x: frame.origin.x, y: frame.origin.y + (top * 0.5), width: frame.size.width, height: frame.size.height)
        }
        return frame.integral
    }
    fileprivate func setup() {
        borderStyle = UITextField.BorderStyle.none
        titleActiveTextColour = tintColor
        // Set up title label
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = titleTextColour
        if let str = placeholder, !str.isEmpty {
            title.text = str
            title.sizeToFit()
        }
        self.addSubview(title)
    }
    fileprivate func maxTopInset() -> CGFloat {
        if let fnt = font {
            return max(0, floor(bounds.size.height - fnt.lineHeight - 4.0))
        }
        return 0
    }
    fileprivate func setTitlePositionForTextAlignment() {
        let frame = textRect(forBounds: bounds)
        var xaxis = frame.origin.x
        if textAlignment == NSTextAlignment.center {
            xaxis = frame.origin.x + (frame.size.width * 0.5) - title.frame.size.width
        } else if textAlignment == NSTextAlignment.right {
            xaxis = frame.origin.x + frame.size.width - title.frame.size.width
        }
        title.frame = CGRect(x: xaxis, y: title.frame.origin.y, width: title.frame.size.width, height: title.frame.size.height)
    }
    fileprivate func showTitle(_ animated: Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay: 0, options: [UIView.AnimationOptions.beginFromCurrentState,
                                                              UIView.AnimationOptions.curveEaseOut], animations: {
            self.title.alpha = 1.0
            var frame = self.title.frame
            frame.origin.y = self.titleYPadding
            self.title.frame = frame
        }, completion: nil)
    }
    fileprivate func hideTitle(_ animated: Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay: 0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseIn], animations: {
            // Animation
            self.title.alpha = 0.0
            var frame = self.title.frame
            frame.origin.y = self.title.font.lineHeight + self.hintYPadding
            self.title.frame = frame
        }, completion: nil)
    }
}
