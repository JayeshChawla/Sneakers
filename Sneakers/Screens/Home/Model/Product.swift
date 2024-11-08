//
//  Product.swift
//  Sneakers
//
//  Created by Quick tech  on 08/11/24.
//

import Foundation

struct Product: Codable {
    let key: String
    let value: String
    let type: String
}

struct ProductResponse: Codable {
    let statuscode: Int
    let msg: String
    let data: [ProductData]
}

struct ProductData: Codable {
    let title: String
    let release_date: String
    let description: String
    let prices: ProductPrices
    let master_image: String
}

struct ProductPrices: Codable {
    let retail_price: Int
}
