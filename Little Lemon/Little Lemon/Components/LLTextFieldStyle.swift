//
//  LLTextFieldStyle.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct LLTextFieldStyle: TextFieldStyle {
    
    @FocusState private var isFocused: Bool
    let icon: Image?
    
    init(icon: Image? = nil) {
        self.icon = icon
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        HStack(spacing: 10) {
            if let icon {
                icon
            }
            configuration
                .font(.DS.paragraphText)
        }
        .focused($isFocused)
        .padding(.horizontal, 10)
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.DS.highlightWhite)
                .overlay {
                    if isFocused {
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.DS.primaryGreen)
                            .transition(.opacity)
                            .animation(.easeInOut, value: isFocused)
                    } else {
                        Button {
                            isFocused = true
                        } label: { Color.clear }
                    }
                    
                }
        }
        
    }
}

#Preview {
    VStack(spacing: 20) {
        TextField("Eg. John Doe", text: .constant(""))
            .textFieldStyle(LLTextFieldStyle())
        TextField("Eg. John Doe", text: .constant(""))
            .textFieldStyle(LLTextFieldStyle(icon: Image(systemName: "magnifyingglass")))
    }
    .padding(20)
}
