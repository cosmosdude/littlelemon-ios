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
    func getMenus(query: String = "", categories: [String] = []) async throws -> [MenuItem] {
        let isFiltering = !(query.isEmpty && categories.isEmpty)
        // only when not filtering, fetch from network
        if !isFiltering {
            do {
                // load from API
                let resp = try await apiModel.getMenus()
                
                // Clear existing ones
                persistance.clear()
                // Create in-memory instances
                resp.forEach {
                    let dish = Dish(context: persistance.viewContext)
                    dish.itemId = Int64($0.id)
                    dish.title = $0.title
                    dish.image = $0.image
                    dish.desc = $0.description
                    dish.price = $0.price
                    dish.category = $0.category
                }
                // save them
                try persistance.viewContext.save()
            } catch {
                print("Error", error)
            }
        }
        
        
        
        // load from core data
        let fetchRequest = Dish.fetchRequest()
        var predicates = [NSPredicate(value: true)]
        if !categories.isEmpty {
            predicates.append(NSPredicate(format: "category IN %@", categories))
        }
        if !query.isEmpty {
            predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", query))
        }
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))]
        
        let dishes = try persistance.viewContext.fetch(fetchRequest)
        
        // convert to domain type
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
    
    @MainActor
    func getCategories() async throws -> [MenuCategory] {
        let fetchRequest = Dish.fetchRequest()
        let dishes = try persistance.viewContext.fetch(fetchRequest)
        let set = Set(dishes.compactMap(\.category))
        return set.map { .init(id: $0, name: $0.capitalized) }.sorted { $0.name < $1.name }
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

