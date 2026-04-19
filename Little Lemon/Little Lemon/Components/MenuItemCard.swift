//
//  MenuItemCard.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct MenuItemCard: View {
    
    let model: MenuItem
    
    init(_ model: MenuItem) {
        self.model = model
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(model.title)
                        .foregroundStyle(Color.DS.highlightBlack)
                        .font(.DS.cardTitle)
                    Text(model.description)
                        .lineLimit(3)
                        .foregroundStyle(Color.DS.primaryGreen)
                        .font(.DS.paragraphText)
                    Text("$\(model.price)")
                        .foregroundStyle(Color.DS.primaryGreen)
                        .font(.DS.highlightText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                AsyncImage(
                    url: model.imageURL,
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

#Preview {
    MenuItemCard(.init(id: 0, title: "Greek Salad", description: "The famous greek salad of crispy lettuce, peppers, olives and our Chicago style feta cheese, garnished with crunchy garlic and rosemary croutons. ", price: "$12.99", image: "https://fastly.picsum.photos/id/365/200/300.jpg?hmac=n_4DxqK0o938eabBZRnEywWtPwgF2MKoTfnRmJ7vlKQ", category: ""))
}
