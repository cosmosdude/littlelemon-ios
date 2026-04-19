//
//  MenuViewModel.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import Combine
import SwiftUI

class MenuViewModel: ObservableObject {
    private let model = MenuModel()
    
    @Published
    private(set) var isFetching = false
    
    private var selectedCategoryIds = Set<String>()
    
    private var query = ""
    
    @Published
    private(set) var categories = [MenuCategory]()
    
    @Published
    private(set) var menuItems = [MenuItem]()
    
    @MainActor
    func fetch() async {
        do {
            let items = try await model.getMenus(query: query, categories: Array(selectedCategoryIds))
            let categories = try await model.getCategories()
            withAnimation {
                menuItems = items
                self.categories = categories
            }
        } catch {
            print("Error", error)
        }
    }
    
    func setQuery(_ text: String) {
        objectWillChange.send()
        query = text
        Task { await fetch() }
    }
    
    func getQuery() -> String {
        query
    }
    
    func toggleCategory(id: String) {
        objectWillChange.send()
        if selectedCategoryIds.contains(id) {
            selectedCategoryIds.remove(id)
        } else {
            selectedCategoryIds.insert(id)
        }
        Task {
            await fetch()
        }
    }
    
    func isSelected(_ category: MenuCategory) -> Bool {
        selectedCategoryIds.contains(category.id)
    }
}
