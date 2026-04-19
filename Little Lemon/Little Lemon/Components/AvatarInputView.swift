//
//  AvatarInputView.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct AvatarInputView: View {
    
    var image: Image?
    var onAdd: (() -> Void)?
    var onUpdate: (() -> Void)?
    var onRemove: (() -> Void)?
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            imageView()
            
            VStack(alignment: .leading) {
                if image == nil {
                    Button("Add") {
                        onAdd?()
                    }
                    .buttonStyle(LLFilledButtonStyle(.small))
                } else {
                    Button("Update") {
                        onUpdate?()
                    }
                    .buttonStyle(LLFilledButtonStyle(.small))
                    
                    Button("Remove") {
                        onRemove?()
                    }
                    .buttonStyle(LLPlainButtonStyle(.small))
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func imageView() -> some View {
        Group {
            if let image {
                image.resizable().scaledToFill()
                    .frame(width: 100, height: 100)
            } else {
                Image(systemName: "photo")
                    .resizable().scaledToFit()
                    .frame(width: 40, height: 40)
            }
            
        }
        .frame(width: 100, height: 100)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.DS.highlightWhite)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    VStack {
        AvatarInputView()
        AvatarInputView(image: Image(""))
    }
    .padding(20)
}
