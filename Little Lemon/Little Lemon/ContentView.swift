//
//  ContentView.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 18/4/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoading = true
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        if isLoading {
            ProgressView()
                .task {
                    try? await PersistenceController.shared.load()
                    withAnimation {
                        isLoading = false
                    }
                }
        } else {
            navGraph()
        }
    }
    
    @ViewBuilder
    private func navGraph() -> some View {
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
