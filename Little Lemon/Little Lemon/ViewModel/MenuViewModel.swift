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
    
    @Published
    private(set) var categories = [MenuCategory]()
    
    @Published
    private(set) var menuItems = [MenuItem]()
    
    @MainActor
    func fetch() async {
        do {
            let items = try await model.getMenus()
            let categorySet = Set(items.map(\.category))
            withAnimation {
                menuItems = items
                categories = categorySet.map {
                    .init(id: $0, name: $0.capitalized)
                }
            }
        } catch {
            print("Error", error)
        }
    }
    
    func toggleCategory(id: String) {
        objectWillChange.send()
        if selectedCategoryIds.contains(id) {
            selectedCategoryIds.remove(id)
        } else {
            selectedCategoryIds.insert(id)
        }
    }
    
    func isSelected(_ category: MenuCategory) -> Bool {
        selectedCategoryIds.contains(category.id)
    }
}
