//
//  NetworkManager.swift
//  EventApp 1
//
//  Created by Vova SKR on 02/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

typealias Void = ()

// MARK: - Protocol
protocol NetworkManagerProtocol {
    
    func getEvents(categories: Categories, page: Int, completion: @escaping (Result<ResultEventsModel, Error>) -> ())
    
    func postSingUp(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> ())
    
    func postSingIn(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> ())
    
    func getSearch(search text: String,completion: @escaping (Result<SearchModel, Error>) -> ())
    
    func firebaseGetData(completion: @escaping (Result<[EventModel], Error>) -> ())
    
    func firebasePutData(event: EventModel, currentDate: Int, completion: @escaping (Result<Void, Error>) -> ())
    
    func firebaseDeleteData(at index: Int, completion: @escaping (Result<Void, Error>) -> ())
}


struct NetworkManager: NetworkManagerProtocol {
    
    private let apiClient = APIClient<NetworkEnvironment>(session: URLSession.shared)
    
    // MARK: - KudaGO API
    public func getEvents(categories: Categories, page: Int, completion: @escaping (Result<ResultEventsModel, Error>) -> ()) {
        
        apiClient.request(.kudaGoAPI(.events(categories: categories, page: page))) { data, response, error in
            guard error == nil else { completion(.failure(error!)); return }
            guard let responseData = data else {
                completion(.failure(APIError.requestFailed ))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(ResultEventsModel.self, from: responseData)
                completion(.success(apiResponse))
            } catch {
                print(error)
                completion(.failure(APIError.jsonParsingFailure))
            }
        }
    }
    
    public func getSearch(search text: String,completion: @escaping (Result<SearchModel, Error>) -> ()) {
        apiClient.request(.kudaGoAPI(.search(text: text))) { (data, responce, error) in
            guard error == nil else { completion(.failure(error!)); return }
            guard let responseData = data else {
                completion(.failure(APIError.requestFailed ))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(SearchModel.self, from: responseData)
                completion(.success(apiResponse))
            } catch {
                print(error)
                completion(.failure(APIError.jsonParsingFailure))
            }
        }
    }
    
    // MARK: - Firebase Auth
    public func postSingUp(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> ()) {
        apiClient.request(.fireBaseAuth(.signUp(email: email, password: password))) { (data, responce, error) in
            
            guard error == nil, let responseData = data else { completion(.failure(APIError.noData)); return }
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                completion(.failure(APIError.requestFailed))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(UserModel.self, from: responseData)
                completion(.success(apiResponse))
            } catch {
                completion(.failure(APIError.jsonParsingFailure))
            }
        }
    }
    
    public func postSingIn(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> ()) {
        apiClient.request(.fireBaseAuth(.signIn(email: email, password: password))) { (data, responce, error) in
            
            guard error == nil, let responseData = data else { completion(.failure(APIError.noData)); return }
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                completion(.failure(APIError.requestFailed))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(UserModel.self, from: responseData)
                completion(.success(apiResponse))
            } catch {
                completion(.failure(APIError.jsonParsingFailure))
            }
        }
    }
    
    
    // MARK: - Firebase DB
    public func firebaseGetData(completion: @escaping (Result<[EventModel], Error>) -> ()) {
        apiClient.request(.firebaseDataBase(.getUserData)) { (data, responce, error) in
            guard error == nil else { completion(.failure(APIError.noData)); return }
            guard let responseData = data else {
                completion(.failure(APIError.requestFailed ))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode([String: EventModel].self, from: responseData)
                let data = Array(apiResponse.values)
                completion(.success(data))
            } catch {
                print(error)
                completion(.failure(APIError.jsonParsingFailure))
            }
        }
    }
    
    
    public func firebasePutData(event: EventModel,currentDate: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        apiClient.request(.firebaseDataBase(.putNewData(data: event, currentDate: currentDate))) { (data, responce, error) in
            
            let httpResponce = responce as? HTTPURLResponse
            
            if httpResponce?.statusCode == 200 {
                
                completion(.failure(APIError.requestFailed))
                
            } else {
                
                completion(.success(()))
            }
            
        }
    }
    
    
    public func firebaseDeleteData(at index: Int, completion: @escaping (Result<Void, Error>) -> ())  {
        apiClient.request(.firebaseDataBase(.deleteData(index: index))) { (_, responce, _) in
            
            let httpResponce = responce as? HTTPURLResponse
            
            if httpResponce?.statusCode == 200 {
                
                completion(.failure(APIError.requestFailed))
                
            } else {
                
                completion(.success(()))
            }
        }
        
    }
}
