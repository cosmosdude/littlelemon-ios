//
//  OnboardingStepsScreen.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct OnboardingStepsScreen: View {
    
    var onGetStarted: () -> Void = {}
    
    @State private var page: Int = 0
    
    var body: some View {
        VStack(spacing: 25) {
            TabView(selection: .init(get: {page}, set: { newValue in
                withAnimation {
                    page = newValue
                }
            })) {
                VStack {
                    Text("Page 1")
                    Text("")
                }
                .tag(0)
                
                VStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.green)
                }
                .tag(1)
                
                VStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.blue)
                }
                .tag(2)
                    
            }
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            pager()
            
            if page < 2 {
                Button("Next") {
                    withAnimation {
                        page += 1
                    }
                }
                .buttonStyle (LLBorderedButtonStyle())
                .padding(.horizontal, 25)
            } else {
                Button("Get Started") {
                    onGetStarted()
                }
                .buttonStyle (LLFilledButtonStyle())
                .padding(.horizontal, 25)
            }
        }
    }
    
    private func pager() -> some View {
        HStack {
            ForEach(0..<3) { index in
                Circle()
                    .stroke(Color.DS.primaryGreen, lineWidth: 2)
                    .frame(width: 15, height: 15)
                    .overlay {
                        if index == page {
                            Circle()
                                .fill(Color.DS.primaryGreen)
                                .frame(width: 8, height: 8)
                        }
                    }
            }
        }
    }
}

#Preview {
    OnboardingStepsScreen()
}
