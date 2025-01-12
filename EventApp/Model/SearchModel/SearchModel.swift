//
//  SearchModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 09/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

struct SearchModel: Codable {
    let count: Int?
    let results: [SearchResultModel]
}

// MARK: - Result
struct SearchResultModel: Codable {
    let id: Int
    let title: String?
    let description: String?
    let address: String?
}
