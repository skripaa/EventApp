//
//  CustomLabel.swift
//  EventApp 1
//
//  Created by Vova SKR on 24/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

extension UILabel {
    
    public static func setupLabel(with font: UIFont, tintColor: UIColor, line number: Int) -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = number
        label.textColor = tintColor
        
        label.font = font
        return label
    }
}
