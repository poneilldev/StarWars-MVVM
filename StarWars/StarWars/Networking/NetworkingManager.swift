//
//  NetworkingManager.swift
//  StarWars
//
//  Created by Paul O'Neill on 2/22/22.
//

import Foundation
import UIKit

enum NetworkManagerError: Error {
    case badHTTPResponse
    case noData
    case badImageData
    case decodingError(Error)
}

struct NetworkingManager {
    static var cache = ImageCacheManager()
    static func loadResource<Element: Decodable>(type: Element.Type, with url: URL) async throws -> Element {
        let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkManagerError.badHTTPResponse
        }
        
        do {
            return try JSONDecoder().decode(Element.self, from: data)
        } catch let error {
            throw NetworkManagerError.decodingError(error)
        }
    }
    
    static func loadImage(for url: URL) async throws -> UIImage {
        if let cachedImage = cache.getCachedImage(for: url) {
            return cachedImage
        }
        
        let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkManagerError.badHTTPResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw NetworkManagerError.badImageData
        }
        
        cache.cacheImage(image, for: url)
        
        return image
    }
    
    // The following two methods are examples of turning a non-async method with a closure into an async method
    
    @available(*, renamed: "oldLoadResource(type:with:)")
    static func oldLoadResource<Element: Decodable>(type: Element.Type, with url: URL, completion: @escaping (_ result: Result<Element, Error>) -> Void) {
        Task {
            do {
                let result: Element = try await oldLoadResource(type: type, with: url)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
    static func oldLoadResource<Element: Decodable>(type: Element.Type, with url: URL) async throws -> Element {
        return try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
//                    continuation.resume(with: .failure(error!))
                    continuation.resume(throwing: error!)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    continuation.resume(with: .failure(NetworkManagerError.badHTTPResponse))
                    return
                }
                
                guard let data1 = data else {
                    continuation.resume(with: .failure(NetworkManagerError.noData))
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(Element.self, from: data1)
                    continuation.resume(with: .success(results))
                } catch let error {
                    continuation.resume(with: .failure(error))
                }
            }
            
            task.resume()
        }
    }
}

class ImageCacheManager {
    static var cache = NSCache<NSString, UIImage>()
    
    func cacheImage(_ image: UIImage, for url: URL) {
        ImageCacheManager.cache.setObject(image, forKey: NSString(string: url.absoluteString))
    }
    
    func getCachedImage(for url: URL) -> UIImage? {
        ImageCacheManager.cache.object(forKey: NSString(string: url.absoluteString))
    }
    
    
}
