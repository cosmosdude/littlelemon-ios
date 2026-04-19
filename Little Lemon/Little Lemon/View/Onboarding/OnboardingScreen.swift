//
//  OnboardingScreen.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct OnboardingScreen: View {
    
    var onLogin: ((User) -> Void)?
    
    @State private var page = 0
    @State private var user = User()
    
    @State private var isSelectingImage = false
    
    @FocusState private var focusedItem: Int!
    
    var body: some View {
        NavigationStack {
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
            .fullScreenCover(isPresented: $isSelectingImage) {
                ImagePickerView { newImage in
                    withAnimation {
                        user.avatar = newImage
                    }
                }
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
            .frame(maxWidth: .infinity, alignment: .leading)
            
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
        VStack(spacing: 10) {
            
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
            
            TabView(selection: $page) {
                firstNameField()
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, 25)
                    .tag(0)
                
                lastNameField()
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, 25)
                    .tag(1)
                
                emailField()
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, 25)
                    .tag(2)
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .frame(height: 200)
//            .border(Color.green)
        }
    }
    
    private func avatar() -> some View {
        VStack(alignment: .leading) {
            Text("Avatar")
                .asLabelText()
            AvatarInputView(image: user.avatar.map { Image(uiImage: $0) }) {
                isSelectingImage = true
            } onUpdate: {
                isSelectingImage = true
            } onRemove: {
                withAnimation {
                    user.avatar = nil
                }
            }
        }
    }
    
    private func firstNameField() -> some View {
        VStack(alignment: .leading) {
            Text("First Name *")
                .asLabelText()
            
            TextField("eg. John", text: $user.firstName)
                .textFieldStyle(LLTextFieldStyle())
                .autocorrectionDisabled()
                .submitLabel(.next)
                .onSubmit {
                    if !user.firstName.isEmpty {
                        page += 1
                    }
                }
            
            Button("Next") {
                withAnimation {
                    page += 1
                }
            }
            .buttonStyle(LLFilledButtonStyle())
            .disabled(user.firstName.isEmpty)
        }
    }
    
    private func lastNameField() -> some View {
        VStack(alignment: .leading) {
            Text("Last Name *")
                .asLabelText()
            
            TextField("eg. Doe", text: $user.lastName)
                .textFieldStyle(LLTextFieldStyle())
                .autocorrectionDisabled()
                .submitLabel(.next)
                .onSubmit {
                    if !user.lastName.isEmpty {
                        page += 1
                    }
                }
            
            Button("Next") {
                withAnimation {
                    page += 1
                }
            }
            .buttonStyle(LLFilledButtonStyle())
            .disabled(user.lastName.isEmpty)
        }
    }
    
    private func emailField() -> some View {
        VStack(alignment: .leading) {
            Text("Email *")
                .asLabelText()
            
            TextField("eg. John", text: $user.email)
                .textFieldStyle(LLTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .submitLabel(.done)
                .onSubmit {
                    if !user.lastName.isEmpty {
                        page += 1
                    }
                }
            
            if !user.email.isEmpty && !Util.isValidEmail(user.email) {
                Text("Invalid email.")
                    .asErrorText()
            }
            
            Button("Get Started") {
                onLogin?(user)
            }
            .buttonStyle(LLFilledButtonStyle())
            .disabled(!Util.isValidEmail(user.email))
        }
    }
    
    
}

#Preview {
    OnboardingScreen()
}
