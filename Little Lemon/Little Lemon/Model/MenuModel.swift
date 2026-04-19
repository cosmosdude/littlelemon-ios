//
//  MenuModel.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import Foundation
import CoreData

class MenuModel {
    
    let apiModel = MenuAPIModel()
    let persistance = PersistenceController.shared
    
    @MainActor
    func getMenus(categories: [String] = []) async throws -> [MenuItem] {
        do {
            let resp = try await apiModel.getMenus()
            
            persistance.clear()
            resp.forEach {
                let dish = Dish(context: persistance.viewContext)
                dish.itemId = Int64($0.id)
                dish.title = $0.title
                dish.image = $0.image
                dish.desc = $0.description
                dish.price = $0.price
                dish.category = $0.category
            }
            try persistance.viewContext.save()
        } catch {
            print("Error", error)
        }
        let fetchRequest = Dish.fetchRequest()
        fetchRequest.predicate = categories.isEmpty ? NSPredicate(value: true) : NSPredicate(value: true)
        
        let dishes = try persistance.viewContext.fetch(fetchRequest)
        
        return dishes.map {
            .init(
                id: Int($0.itemId),
                title: $0.title ?? "",
                description: $0.desc ?? "",
                price: $0.price ?? "",
                image: $0.image ?? "",
                category: $0.category ?? ""
            )
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

