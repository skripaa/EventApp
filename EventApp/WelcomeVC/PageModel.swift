//
//  Page.swift
//  EventApp 1
//
//  Created by Vova SKR on 22/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

struct WelcomePageModel {
    let imageName: String? = nil
    let headerText: String
    let bodyText: String
    
    static func all() -> [WelcomePageModel] {
        
        return [WelcomePageModel(headerText:"Добро пожаловать!", bodyText: "Это приложение по поиску событий в Москве"),
                WelcomePageModel(headerText: "Все в одном месте", bodyText: "Все самые яркие, интересные и впечатляющие мероприятия, собранны в одном месте."),
                WelcomePageModel(headerText: "Сохраняйте в избранное", bodyText: "Сохраняйте понравившиеся событияn себе в закладки, чтобы не потерять их")]
    }
}
