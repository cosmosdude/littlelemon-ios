//
//  LLBorderedButtonStyle.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct LLBorderedButtonStyle: ButtonStyle {
    
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
                ? Color.DS.primaryGreen
                : Color.DS.highlightWhite
            )
            .font(
                size == .large
                ? .DS.cta
                : .DS.highlightText
            )
            .padding(.horizontal, 10)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isEnabled
                        ? Color.DS.primaryGreen
                        : Color.DS.highlightWhite
                    )
            }
            .opacity(configuration.isPressed ? 0.75 : 1)
        
    }
    
}

#Preview {
    VStack {
        Button("Small") {
            
        }
        .buttonStyle(LLBorderedButtonStyle(.small))
        
        Button("Small") {
            
        }
        .buttonStyle(LLBorderedButtonStyle(.small))
        .disabled(true)
        
        Button("Large") {
            
        }
        .buttonStyle(LLBorderedButtonStyle())
        
        Button("Large") {
            
        }
        .buttonStyle(LLBorderedButtonStyle())
        .disabled(true)
    }
    .padding(20)
}
