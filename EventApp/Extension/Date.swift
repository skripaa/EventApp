//
//  Date.swift
//  EventApp 1
//
//  Created by Vova SKR on 07/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

extension Date {
    func string() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMddhhmmss"
        return formatter.string(from: self)
    }
}
