//
//  CustomTextField.swift
//  EventApp 1
//
//  Created by Vova SKR on 04/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

extension UITextField {
    
     public static func logIn(with placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.frame.size = CGSize(width: 100, height: 120)
        textField.backgroundColor = .white

        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.placeholder = " " + placeholder
        
        textField.borderStyle = .none
        textField.layer.backgroundColor = UIColor.white.cgColor

        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.mainRed.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textField.layer.shadowOpacity = 5.0
        textField.layer.shadowRadius = 0.0
        
        return textField
    }
    
      public func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor

        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
}

