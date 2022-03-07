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
