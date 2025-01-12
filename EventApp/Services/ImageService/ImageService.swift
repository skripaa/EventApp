//
//  ImageService.swift
//  EventApp 1
//
//  Created by Vova SKR on 27/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class ImageService {
    
    static let cashe = NSCache<NSString, UIImage>()
    
    static func downloadImage(withURL url: URL, comlection: @escaping(Result<UIImage, Error>) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                
                comlection(.failure(APIError.noData))
                return
            }
            
            cashe.setObject(downloadedImage, forKey: url.absoluteString as NSString)
            
            DispatchQueue.main.async {
                comlection(.success(downloadedImage))
            }
        }.resume()
    }
    
    static func getImage(withURL url: URL, comlection:  @escaping(Result<UIImage, Error>) -> ()) {
        if let image = cashe.object(forKey: url.absoluteString as NSString) {
            comlection(.success(image))
        } else {
            downloadImage(withURL: url, comlection: comlection)
        }
    }
    
}
