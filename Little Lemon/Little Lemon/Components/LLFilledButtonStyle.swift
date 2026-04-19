//
//  LLFilledButtonStyle.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct LLFilledButtonStyle: ButtonStyle {
    
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
                : Color.gray
            )
            .font(
                size == .large
                ? .DS.cta
                : .DS.highlightText
            )
            .padding(.horizontal, 10)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        isEnabled
                        ? Color.DS.primaryYellow
                        : Color.DS.highlightWhite
                    )
                    .overlay {
                        if isEnabled {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.DS.secondaryRed)
                        }
                    }
            }
            .opacity(configuration.isPressed ? 0.75 : 1)
        
    }
    
}

#Preview {
    VStack {
        Button("Small") {
            
        }
        .buttonStyle(LLFilledButtonStyle(.small))
        
        Button("Small") {
            
        }
        .buttonStyle(LLFilledButtonStyle(.small))
        .disabled(true)
        
        Button("Large") {
            
        }
        .buttonStyle(LLFilledButtonStyle())
        
        Button("Large") {
            
        }
        .buttonStyle(LLFilledButtonStyle())
        .disabled(true)
    }
    .padding(20)
}
