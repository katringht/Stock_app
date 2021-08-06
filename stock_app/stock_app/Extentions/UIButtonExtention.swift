//
//  File.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 06.08.2021.
//

import UIKit

extension UIButton{
    func setSelectedColor() {
        self.setTitleColor(.black, for: .normal)
        
    }
    
    func setDeselectedColor() {
        self.setTitleColor(.systemGray2, for: .normal)
    }
}
