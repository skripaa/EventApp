//
//  UserModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 04/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    
    var email: String?
    var refreshToken: String?
    var expiresIn: String?
    var localId: String?
}
