//
//  ContentView.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 18/4/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        if viewModel.isLoggedIn {
            MenuScreen(onLogout: {
                viewModel.logout()
            })
        } else {
            OnboardingScreen(onLogin: { user in
                withAnimation {
                    viewModel.login(user)
                }
            })
        }
    }
    
}

#Preview {
    ContentView()
}
