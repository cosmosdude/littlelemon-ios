//
//  LLPlainButtonStyle.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct LLPlainButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    enum SizeType { case small, large }
    
    let size: SizeType
    
    init (_ size: SizeType = .large) {
        self.size = size
    }
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .frame(maxWidth: size == .large ? .infinity : nil)
            .frame(height: size == .large ? 40 : 24)
            .foregroundStyle(
                isEnabled
                ? Color.DS.highlightBlack
                : Color.DS.highlightWhite
            )
            .font(
                size == .large
                ? .DS.cta
                : .DS.highlightText
            )
            .padding(.horizontal, size == .large ? 10 : 0)
            .opacity(configuration.isPressed ? 0.65 : 1)
        
    }
    
}

#Preview {
    VStack {
        Button("Small") {
            
        }
        .buttonStyle(LLPlainButtonStyle(.small))
        
        Button("Small") {
            
        }
        .buttonStyle(LLPlainButtonStyle(.small))
        .disabled(true)
        
        Button("Large") {
            
        }
        .buttonStyle(LLPlainButtonStyle())
        
        Button("Large") {
            
        }
        .buttonStyle(LLPlainButtonStyle())
        .disabled(true)
    }
    .padding(20)
}
