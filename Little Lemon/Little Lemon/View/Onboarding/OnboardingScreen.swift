//
//  OnboardingScreen.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct OnboardingScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                hero()
                form()
            }
            .padding(.bottom, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("images/logo")
            }
        }
    }
    
    private func hero() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Little Lemon")
                    .font(.DS.displayTitle)
                    .foregroundStyle(Color.DS.primaryYellow)
                Text("Chicago")
                    .font(.DS.subtitle)
                    .foregroundStyle(Color.DS.highlightWhite)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top, spacing: 5) {
                    Text("We are family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.DS.leadText)
                        .foregroundStyle(Color.DS.highlightWhite)
                    
                    Image("images/hero")
                        .resizable().scaledToFit()
                        .frame(width: 125, height: 125)
                }
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 20)
        .background(Color.DS.primaryGreen)
    }
    
    private func form() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            avatar()
            nameFields()
            emailField()
            Button("Next") {
                
            }
            .buttonStyle(LLFilledButtonStyle())
            .disabled(true)
        }
        .padding(.horizontal, 25)
    }
    
    private func avatar() -> some View {
        VStack(alignment: .leading) {
            Text("Avatar *")
                .asLabelText()
            
            HStack(alignment: .top, spacing: 20) {
                Group {
                    Image(systemName: "photo")
                        .resizable().scaledToFit()
                        .frame(width: 40, height: 40)
                }
                .frame(width: 100, height: 100)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.DS.highlightWhite)
                }
                
                VStack(alignment: .leading) {
                    Button("Add") {
                        
                    }
                    .buttonStyle(LLFilledButtonStyle(.small))
                }
            }
            
        }
    }
    
    private func nameFields() -> some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading) {
                Text("First Name *")
                    .asLabelText()
                
                TextField("eg. John", text: .constant(""))
                    .textFieldStyle(LLTextFieldStyle())
                
                Text("Must not be empty")
                    .asErrorText()
            }
            
            VStack(alignment: .leading) {
                Text("Last Name")
                    .asLabelText()
                
                TextField("eg. Doe", text: .constant(""))
                    .textFieldStyle(LLTextFieldStyle())
            }
        }
    }
    
    private func emailField() -> some View {
        VStack(alignment: .leading) {
            Text("Email *")
                .asLabelText()
            
            TextField("eg. John", text: .constant(""))
                .textFieldStyle(LLTextFieldStyle())
            
            Text("Invalid email.")
                .asErrorText()
        }
    }
}

#Preview {
    NavigationStack {
        OnboardingScreen()
    }
}
