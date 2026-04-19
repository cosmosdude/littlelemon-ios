//
//  LLCategoryButtonStyle.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct LLCategoryButtonStyle: ButtonStyle {
    
    private let isSelected: Bool
    
    init(selected: Bool = false) {
        self.isSelected = selected
    }
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .frame(height: 40)
            .foregroundStyle(
                isSelected
                ? Color.DS.highlightWhite
                : Color.DS.highlightBlack
            )
            .font(.DS.categoryTitle)
            .padding(.horizontal, 10)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        isSelected
                        ? Color.DS.primaryGreen
                        : Color.DS.highlightWhite
                    )
            }
            .opacity(configuration.isPressed ? 0.75 : 1)
    }
    
}

extension Button {
    func asCategoryButton(selected: Bool = false) -> some View {
        buttonStyle(LLCategoryButtonStyle(selected: selected))
    }
}

#Preview {
    VStack {
        Button("Breakfast") {
            
        }
        .buttonStyle(LLCategoryButtonStyle(selected: false))
        
        Button("Lunch") {
            
        }
        .buttonStyle(LLCategoryButtonStyle(selected: true))
    }
    .padding(20)
}
