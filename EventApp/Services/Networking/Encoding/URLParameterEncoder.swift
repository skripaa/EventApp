//
//  URLParameterEncoder.swift
//  EventApp 1
//
//  Created by Vova SKR on 02/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
    }
}
