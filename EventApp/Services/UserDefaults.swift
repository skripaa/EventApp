//
//  UserDefaults.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func setIsFirstTime(value: Bool) {
        
        set(value, forKey: "isFirstTime")
        synchronize()
    }
    
    func isFirstTime() -> Bool {
        
        bool(forKey: "isFirstTime")
    }
    
    
    // MARK: - UserID
    
    func setUserId(id: String, userName: String) {
        
        set(id, forKey: "UserId")
        set(userName, forKey: "UserName")
        synchronize()
    }
    
    func userId() -> String {
        
        string(forKey: "UserId") ?? ""
    }
    
    func userEmail() -> String {
        
        string(forKey: "UserName") ?? "userName"
    }
    
    func deleteUserId() {
        
        setUserId(id: "", userName: "")
    }
}
