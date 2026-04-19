//
//  MenuAPIModel.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import Foundation

class MenuAPIModel {
    
    private let session = URLSession.shared
    
    init() { }
    
    func getMenus() async throws -> [MenuItemAPIResponse] {
        guard let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")
        else { return [] }
        
        let (data, resp) = try await session.data(from: url)
        return try JSONDecoder().decode(MenuListAPIResponse.self, from: data).menu
    }
    
}

struct MenuListAPIResponse: Codable {
    let menu: [MenuItemAPIResponse]
}

struct MenuItemAPIResponse: Codable {
    let id: Int
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
}


