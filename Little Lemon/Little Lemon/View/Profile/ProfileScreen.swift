//
//  ProfileScreen.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct ProfileScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isSelectingImage = false
    @State private var isConfirmingLogout = false
    
    @StateObject private var viewModel = LoginViewModel()
    
    @State private var lastUser = User()
    @State private var user = User()
    
    @FocusState private var focusedItem: Int!
    
    var onLogout: (() -> Void)?
    init(onLogout: (() -> Void)? = nil) {
        self.onLogout = onLogout
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                title()
                    .padding(.horizontal, 25)
                
                form()
                    .padding(.horizontal, 25)
                
                logoutButton()
                    .padding(.horizontal, 25)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "arrow.left")
                }
            }
            ToolbarItem(placement: .principal) {
                Image("images/logo")
            }
        }
        .onAppear {
            lastUser = viewModel.user ?? User()
            user = lastUser
        }
        .fullScreenCover(isPresented: $isSelectingImage) {
            ImagePickerView { newImage in
                withAnimation {
                    user.avatar = newImage
                }
            }
        }
    }
    
    private func title() -> some View {
        Text("Personal Information")
            .lineSpacing(-21)
            .font(.DS.displayTitle)
            .foregroundStyle(Color.DS.highlightBlack)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func form() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            avatar()
            nameFields()
                .autocorrectionDisabled()
            
            emailField()
                .autocorrectionDisabled()
            
            buttons()
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
    
    private func nameFields() -> some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading) {
                Text("First Name *")
                    .asLabelText()
                
                TextField("eg. John", text: $user.firstName)
                    .textFieldStyle(LLTextFieldStyle())
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
    
    private func buttons() -> some View {
        HStack(alignment: .top, spacing: 20) {
            Button("Discard") {
                withAnimation {
                    user = lastUser
                }
            }
            .buttonStyle(LLPlainButtonStyle())
            .disabled(lastUser == user)
            
            Button("Save") {
                viewModel.user = user
                lastUser = user
            }
            .buttonStyle(LLBorderedButtonStyle())
            .disabled(lastUser == user || user.firstName.isEmpty || !Util.isValidEmail(user.email))
        }
    }
    
    private func logoutButton() -> some View {
        Button("Logout") {
            isConfirmingLogout = true
        }
        .buttonStyle(LLFilledButtonStyle())
        .confirmationDialog(
            "Logout?",
            isPresented: $isConfirmingLogout
        ) {
            Button("Confirm") {
                onLogout?()
            }
            Button("Cancel") { }
        }
    }
    
}

#Preview {
    NavigationStack {
        ProfileScreen()
    }
}
