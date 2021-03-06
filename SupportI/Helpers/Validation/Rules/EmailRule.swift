//
//  EmailValidation.swift
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

/**
 `EmailRule` is a subclass of RegexRule that defines how a email is validated.
 */
public class EmailRule: RegexRule {

    /// Regular express string to be used in validation.
    static let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"

    /**
     Initializes an `EmailRule` object to validate an email text field.
     
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public convenience init(message: String = "") {
        self.init(regex: EmailRule.regex, message: "must_be_a_valid_email_address.lan".localized)
    }
}
