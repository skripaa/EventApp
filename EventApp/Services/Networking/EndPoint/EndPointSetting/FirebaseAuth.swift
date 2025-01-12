//
//  FirebaseAuth.swift
//  EventApp 1
//
//  Created by Vova SKR on 05/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

public enum Auth {
    case signUp(email: String, password: String)
    case signIn(email: String, password: String)
}
