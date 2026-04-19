//
//  OnboardingScreen.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct OnboardingScreen: View {
    
    var onLogin: ((User) -> Void)?
    
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
        VStack(alignment: .leading, spacing: 20) {
            avatar()
            nameFields()
            
            emailField()
            
            Button("Get Started") {
                onLogin?(user)
            }
            .buttonStyle(LLFilledButtonStyle())
            .disabled(user.firstName.isEmpty || !Util.isValidEmail(user.email))
        }
        .padding(.horizontal, 25)
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
    
    private func nameFields() -> some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading) {
                Text("First Name *")
                    .asLabelText()
                
                TextField("eg. John", text: $user.firstName)
                    .textFieldStyle(LLTextFieldStyle())
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                    .focused($focusedItem, equals: 1)
                    .onSubmit {
                        focusedItem! += 1
                    }
            }
            
            VStack(alignment: .leading) {
                Text("Last Name")
                    .asLabelText()
                
                TextField("eg. Doe", text: $user.lastName)
                    .textFieldStyle(LLTextFieldStyle())
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                    .focused($focusedItem, equals: 2)
                    .onSubmit {
                        focusedItem! += 1
                    }
            }
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
                .focused($focusedItem, equals: 3)
                .onSubmit {
                    focusedItem = nil
                }
            
            if !user.email.isEmpty && !Util.isValidEmail(user.email) {
                Text("Invalid email.")
                    .asErrorText()
            }
        }
    }
    
    
}

#Preview {
    OnboardingScreen()
}
