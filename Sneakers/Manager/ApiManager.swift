//
//  ApiManager.swift
//  Sneakers
//
//  Created by Quick tech  on 08/11/24.
//

import Foundation

enum DataError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case message(Error?)
}

class ApiManager {
    
    static let shared = ApiManager()
    
    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType
    ) async throws -> T {
        
        guard let url = type.url else { throw DataError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.methods.rawValue
        if let parameters = type.body {
            request.httpBody = try JSONEncoder().encode(parameters)
        }
        request.allHTTPHeaderFields = type.headers
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResonse = response as? HTTPURLResponse {
                guard 200...299 ~= httpResonse.statusCode else {
                    throw DataError.invalidResponse
                }
            }
            
            let decodeData = try JSONDecoder().decode(modelType, from: data)
            return decodeData
        } catch {
            throw DataError.message(error)
        }
    }
    
    static var commonHeaders: [String: String] {
        return ["Content-Type": "application/json"]
    }
}
