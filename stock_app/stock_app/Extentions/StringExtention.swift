//
//  StringExtention.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 07.08.2021.
//

import UIKit

extension String{
    var isValidEmail: Bool {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicat = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicat.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let regularExpression = "[A-Z0-9a-z]{8,20}"
        let predicat = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicat.evaluate(with: self)
    }
}
