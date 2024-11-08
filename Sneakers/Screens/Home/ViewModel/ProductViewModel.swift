//
//  ProductViewModel.swift
//  Sneakers
//
//  Created by Quick tech  on 08/11/24.
//

import Foundation

class ProductViewModel {
    
    private let manager = ApiManager()
    var product: Product!
    var productData: [ProductData] = []
    var errorMessage: String? = nil
    
    func fetchProducts(parameters: Product, completion: @escaping (Result<Any, Error>) -> Void) {
        Task {
            do {
                let productResponse = try await ApiManager.shared.request(modelType: ProductResponse.self, type: EndPointItems.product(product: parameters))
                self.productData = productResponse.data
                completion(.success(self.productData))
            } catch {
                print("Error while fetching : \(error)")
                completion(.failure(error))
            }
        }
    }
}
