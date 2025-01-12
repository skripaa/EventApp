//
//  ImageModel.swift
//  EventApp 1
//
//  Created by Vova SKR on 08/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

// MARK: - Image
public struct ImageModel: Codable {
    var image: String
    var thumbnails: Thumbnails?
}

public struct Thumbnails: Codable {
    var the640X384: String?
    var the144X96: String?
    
    enum CodingKeys: String, CodingKey {
        case the640X384 = "640x384"
        case the144X96 = "144x96"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.the640X384 = try? container.decode(String.self, forKey: .the640X384)
            self.the144X96 = try? container.decode(String.self, forKey: .the144X96)
        } catch {
            assertionFailure("Error")
        }
    }
}
