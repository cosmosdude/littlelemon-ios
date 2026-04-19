//
//  MenuScreen.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct MenuScreen: View {
    
    @State private var navPath = NavigationPath()
    var onLogout: (() -> Void)?
    
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var menuViewModel = MenuViewModel()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    hero()
                    categoryFilters()
                    if menuViewModel.isFetching && menuViewModel.menuItems.isEmpty {
                        ProgressView()
                    } else {
                        menus()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("images/logo")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        navPath.append("profile")
                    } label: {
                        if let avatar = userViewModel.user?.avatar {
                            Image(uiImage: avatar)
                                .resizable().scaledToFill()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.fill")
                        }
                    }
                }
            }
            .navigationDestination(for: String.self) { _ in
                ProfileScreen(onLogout: onLogout)
            }
            .task {
                await menuViewModel.fetch()
            }
        }
        
    }
    
    private func hero() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Little Lemon")
                    .font(.DS.displayTitle)
                    .foregroundStyle(Color.DS.primaryYellow)
                Text("Chicago")
                    .font(.DS.subtitle)
                    .foregroundStyle(Color.DS.highlightWhite)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top, spacing: 5) {
                    Text("We are family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.DS.leadText)
                        .foregroundStyle(Color.DS.highlightWhite)
                    
                    Image("images/hero")
                        .resizable().scaledToFit()
                        .frame(width: 125, height: 125)
                }
                
                TextField("Search", text: .init(get: {
                    menuViewModel.getQuery()
                }, set: {
                    menuViewModel.setQuery($0)
                }))
                    .textFieldStyle(LLTextFieldStyle(icon: Image(systemName: "magnifyingglass")))
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 20)
        .background(Color.DS.primaryGreen)
    }
    
    private func categoryFilters() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .center) {
                Text("ORDER FOR DELIVERY")
                    .font(.DS.sectionTitle)
                Image("icons/delivery-van")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 25)
            .padding(.top, 20)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    if menuViewModel.categories.isEmpty && menuViewModel.isFetching {
                        ProgressView()
                    } else {
                        ForEach(menuViewModel.categories, id: \.id) { category in
                            Button(category.name) {
                                menuViewModel.toggleCategory(id: category.id)
                            }
                            .asCategoryButton(selected: menuViewModel.isSelected(category))
                        }
                    }
                        
                }
                .padding(.horizontal, 25)
            }
            .scrollIndicators(.hidden)
            .frame(height: 40)
            
            Color.DS.highlightWhite.frame(height: 1)
        }
        .background(Color.white)
    }
    
    private func menus() -> some View {
        
        ForEach(menuViewModel.menuItems, id: \.id) { menuItem in
            MenuItemCard(menuItem)
        }

    }
}

#Preview {
//    NavigationStack {
        MenuScreen()
//    }
}
