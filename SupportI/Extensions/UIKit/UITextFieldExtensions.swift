//
//  UITextFieldExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 SwifterSwift
//

import UIKit

#if !os(watchOS)
// MARK: - Enums

public extension UITextField {

	/// SwifterSwift: UITextField text type.
	///
	/// - emailAddress: UITextField is used to enter email addresses.
	/// - password: UITextField is used to enter passwords.
	/// - generic: UITextField is used to enter generic text.
    enum TextType {
		case emailAddress
		case password
		case generic
	}

}

// MARK: - Properties
private var maxLengths = [UITextField: Int]()
public extension UITextField {

	/// SwifterSwift: Set textField for common text types.
    var textType: TextType {
		get {
			if keyboardType == .emailAddress {
				return .emailAddress
			} else if isSecureTextEntry {
				return .password
			}
			return .generic
		}
		set {
			switch newValue {
			case .emailAddress:
				keyboardType = .emailAddress
				autocorrectionType = .no
				autocapitalizationType = .none
				isSecureTextEntry = false
				placeholder = "Email Address"

			case .password:
				keyboardType = .asciiCapable
				autocorrectionType = .no
				autocapitalizationType = .none
				isSecureTextEntry = true
				placeholder = "Password"

			case .generic:
				isSecureTextEntry = false
			}
		}
	}

	/// SwifterSwift: Check if text field is empty.
    var isEmpty: Bool {
		return text?.isEmpty == true
	}

	/// SwifterSwift: Return text with no spaces or new lines in beginning and end.
    var trimmedText: String? {
		return text?.trimmingCharacters(in: .whitespacesAndNewlines)
	}

	/// SwifterSwift: Check if textFields text is a valid email format.
	///
	///		textField.text = "john@doe.com"
	///		textField.hasValidEmail -> true
	///
	///		textField.text = "swifterswift"
	///		textField.hasValidEmail -> false
	///
    var hasValidEmail: Bool {
		// http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
		return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
						   options: String.CompareOptions.regularExpression,
						   range: nil, locale: nil) != nil
	}

	/// SwifterSwift: Left view tint color.
	@IBInspectable var leftViewTintColor: UIColor? {
		get {
			guard let iconView = leftView as? UIImageView else { return nil }
			return iconView.tintColor
		}
		set {
			guard let iconView = leftView as? UIImageView else { return }
			iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
			iconView.tintColor = newValue
		}
	}

	/// SwifterSwift: Right view tint color.
	@IBInspectable var rightViewTintColor: UIColor? {
		get {
			guard let iconView = rightView as? UIImageView else { return nil }
			return iconView.tintColor
		}
		set {
			guard let iconView = rightView as? UIImageView else { return }
			iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
			iconView.tintColor = newValue
		}
	}

}
extension UITextField {
    func underlinedFull(hexa: String) {
        let border = CALayer()
        let width = CGFloat(1.5)
        border.borderColor = self.hexaCodeToColor(hex: hexa).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func changeColor() {
        let str = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor:
            UIColor(red: 129/255, green: 186/255, blue: 0/255, alpha: 1)])
        self.attributedText = str
    }
    func changeColorPlaceHolder(holder: String) {
        let str = NSAttributedString(string: holder, attributes: [NSAttributedString.Key.foregroundColor:
            UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)])
        self.attributedPlaceholder = str
    }
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    // Next step here
}

// MARK: - Methods
public extension UITextField {

	/// SwifterSwift: Clear text.
    func clear() {
		text = ""
		attributedText = NSAttributedString(string: "")
	}

	/// SwifterSwift: Set placeholder text color.
	///
	/// - Parameter color: placeholder text color.
    func setPlaceHolderTextColor(_ color: UIColor) {
		guard let holder = placeholder, !holder.isEmpty else { return }
		self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
	}

	/// SwifterSwift: Add padding to the left of the textfield rect.
	///
	/// - Parameter padding: amount of padding to apply to the left of the textfield rect.
    func addPaddingLeft(_ padding: CGFloat) {
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
		leftView = paddingView
		leftViewMode = .always
	}

	/// SwifterSwift: Add padding to the left of the textfield rect.
	///
	/// - Parameters:
	///   - image: left image
	///   - padding: amount of padding between icon and the left of textfield
    func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
		let imageView = UIImageView(image: image)
		imageView.contentMode = .center
		self.leftView = imageView
		self.leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        self.leftViewMode = UITextField.ViewMode.always
	}
   
    
    @IBInspectable var maxLength: Int {
            get {
                guard let lll = maxLengths[self] else {
                    return 150 // (global default-limit. or just, Int.max)
                }
                return lll
            }
            set {
                maxLengths[self] = newValue
                addTarget(self, action: #selector(fix), for: .editingChanged)
            }
        }
        @objc func fix(textField: UITextField) {
            if let ttt = textField.text {
                textField.text = String(ttt.prefix(maxLength))
            }
        }

}

#endif
