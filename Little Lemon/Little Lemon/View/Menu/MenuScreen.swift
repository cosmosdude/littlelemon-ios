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
    
    private let categories = [
        "Lunch", "Main", "Deserts", "A La Carte", "Specials"
    ]
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    hero()
                    categoryFilters()
                    menus()
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
                
                TextField("Search", text: .constant(""))
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
                    ForEach(categories, id: \.self) {
                        Button($0) {
                            
                        }
                        .asCategoryButton(selected: $0 == "Lunch")
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
        ForEach(0..<100) { _ in
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Greek Salad")
                            .foregroundStyle(Color.DS.highlightBlack)
                            .font(.DS.cardTitle)
                        Text("The famous greek salad of crispy lettuce, peppers, olives and our Chicago style feta cheese, garnished with crunchy garlic and rosemary croutons. ")
                            .lineLimit(3)
                            .foregroundStyle(Color.DS.primaryGreen)
                            .font(.DS.paragraphText)
                        Text("$12.99")
                            .foregroundStyle(Color.DS.primaryGreen)
                            .font(.DS.highlightText)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    AsyncImage(
                        url: URL(string: "https://fastly.picsum.photos/id/365/200/300.jpg?hmac=n_4DxqK0o938eabBZRnEywWtPwgF2MKoTfnRmJ7vlKQ"),
                        content: { img in
                            img.resizable().scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        },
                        placeholder: {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.DS.highlightWhite)
                                .frame(width: 80, height: 80)
                                .overlay {
                                    ProgressView()
                                }
                        })
                }
                .padding(20)
                Color.DS.highlightWhite.frame(height: 1)
            }
        }
    }
}

#Preview {
//    NavigationStack {
        MenuScreen()
//    }
}
