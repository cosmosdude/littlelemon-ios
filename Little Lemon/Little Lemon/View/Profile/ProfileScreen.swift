//
//  ProfileScreen.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

struct ProfileScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isConfirmingLogout = false
    
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
            emailField()
            buttons()
                .disabled(true)
        }
    }
    
    private func avatar() -> some View {
        
        VStack(alignment: .leading) {
            Text("Avatar")
                .asLabelText()
            
            AvatarInputView(image: Image("")) {
                
            } onUpdate: {
                
            } onRemove: {
                
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
    
    private func buttons() -> some View {
        HStack(alignment: .top, spacing: 20) {
            Button("Discard Changes") {
                
            }
            .buttonStyle(LLPlainButtonStyle())
            
            Button("Save") {
                
            }
            .buttonStyle(LLBorderedButtonStyle())
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
