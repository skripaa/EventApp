//
//  EventsModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 26/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ResultEventsModel: Codable {
    var count: Int?
    var next: String?
    var results: [EventModel]?
}

// MARK: - Result

struct EventModel: Codable {
    
    var id: Int?
    var title: String
    var date: Int?
    var bodyText, price: String
    var dates: [DateModel]
    var place: PlaceModel?
    var images: [ImageModel]
    var shortTitle: String
}






