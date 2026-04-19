//
//  MenuModel.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import Foundation

class MenuModel {
    
    let apiModel = MenuAPIModel()
    
    func getMenus() async throws -> [MenuItem] {
        let resp = try await apiModel.getMenus()
        return resp.map {
            .init(id: $0.id, title: $0.title, description: $0.description, price: $0.price, image: $0.image, category: $0.category)
        }
    }
    
}

struct MenuItem {
    let id: Int
    let title: String
    let description: String
    let price: String
    let image: String
    var imageURL: URL? { URL(string: image) }
    let category: String
}

struct MenuCategory {
    let id: String
    let name: String
}

