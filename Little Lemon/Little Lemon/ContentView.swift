//
//  ContentView.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 18/4/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoggedIn = false
    
    var body: some View {
        if isLoggedIn {
            MenuScreen(onLogout: {
                withAnimation {
                    isLoggedIn = false
                }
            })
        } else {
            OnboardingScreen(onLogin: {
                withAnimation {
                    isLoggedIn = true
                }
            })
        }
    }
    
}

#Preview {
    ContentView()
}
