import UIKit

var validatorArray = [UITextField:[Rule]]()
extension UITextField{
    
    @IBInspectable public var validationRules: String {
        get {
            return ""
        }
        set {
            validatorArray[self] = self.validations(rules: newValue)
        }
    }
    public var customValidationRules: [Rule] {
        get {
            return []
        }
        set {
            validatorArray[self] = newValue
        }
    }
    
    public func validations(rules:String) -> [Rule]  {
        let rulesArray = rules.split(separator: "|")
        var rulesValide = [Rule]()
        for rule in rulesArray{
            switch rule{
            case "required":
                rulesValide.append(RequiredRule())
            case "email":
                rulesValide.append(EmailRule())
            case "float":
                rulesValide.append(FloatRule())
            case "password":
                rulesValide.append(PasswordRule())
                
            default:
                break
            }
        }
        return rulesValide
    }
    public func validator()->[Rule]{
        if let valid = validatorArray[self]{
            return valid
        }
        return []
    }
}
