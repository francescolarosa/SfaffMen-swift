//
//  CustomCategories.swift
//  StaffMen
//
//  Created by Andrex on 13/03/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

extension UITextField {
    
    public var isNull: Bool    {
        if let t = self.text {
            return t.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty
        }
        return false
    }
    
    public var isValidEmail: Bool {
        if (text == nil || (text?.isEmpty)!) { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text)
    }
}
