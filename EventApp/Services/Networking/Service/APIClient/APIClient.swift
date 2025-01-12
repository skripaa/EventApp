//
//  APIClient.swift
//  EventApp 1
//
//  Created by Vova SKR on 02/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

typealias APIClientCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()

protocol APIClientProtocol: AnyObject {
    
    associatedtype EndPoint: EndPointType
    
    func request(_ route: EndPoint, completion: @escaping APIClientCompletion)
    func cancel()
}

final class APIClient<EndPoint: EndPointType>: APIClientProtocol {
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping APIClientCompletion) {
        
        do {
            let request = try self.buildRequest(from: route)
            
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
                
            case .request: request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters, let bodyEncoding, let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters, request: &request)
                
                
            case .requestParametersAndHeaders(let bodyParameters, let bodyEncoding,
                                              let urlParameters, let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                
                try self.configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding, urlParameters: urlParameters, request: &request)
                
            }
            return request
            
        } catch { throw error }
    }
    
    private func configureParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            
            try bodyEncoding.encode(urlRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
            
            
        } catch { throw error }
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}

