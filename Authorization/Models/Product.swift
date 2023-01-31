//
//  Product.swift
//  Nike
//
//  Created by Dauren Sarsenov on 27.01.2023.
//

import SwiftUI

//Product Model
struct Product: Identifiable,Hashable {
    
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
//    var price: String
    var price: Int
    var productImage: String = ""
    var quantity: Int = 1
    var describe: String
    
}

//Product Types
enum ProductType: String, CaseIterable {
    
    case lifestyle = "Lifestyle"
    case basketball = "Basketball"
    case winter1 = "Winter"
    case football = "Football"
    case running1 = "Running"
    case jordan1 = "Jordan"
}
