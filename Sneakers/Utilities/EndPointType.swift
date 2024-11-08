//
//  EndPointType.swift
//  Sneakers
//
//  Created by Quick tech  on 08/11/24.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var methods: HTTPMethods { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
}

enum EndPointItems {
    case product(product: Product)
}

extension EndPointItems: EndPointType {
    var path: String {
        switch self {
        case .product:
            return "getkofProducts"
        }
    }
    
    var baseURL: String {
        return "https://wallspics.com/api/sneaker/"
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var methods: HTTPMethods {
        switch self {
        case .product:
            return .post
        }
    }
    
    var body: (any Encodable)? {
        switch self {
        case .product( let products):
            return products
        }
    }
    
    var headers: [String : String]? {
        var defaultHeaders = ApiManager.commonHeaders
        defaultHeaders["Static"] = "1"
        defaultHeaders["Device"] = "1e7eff1b-6d9b-460c-b3d1-d408d1518655"
        defaultHeaders["Package"] = "com.shoesly.sneaker.release"
        defaultHeaders["Token"] = "s68Il2RakXpm31OIkKXBzucEfZkM9ybG"
        defaultHeaders["Auth"] = "aiFY1sI2sSFMvrX"
        defaultHeaders["Cookie"] = "cisession=ab1f04616bf38fe3345db8e0ea43008f96c457dd"
        return defaultHeaders
    }
    
    
}
