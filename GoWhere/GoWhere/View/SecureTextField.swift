//
//  SecureTextField.swift
//  LoginCoreData

import SwiftUI

// A reusable view for secure text field with visibility toggle
// A reusable secure text field with eye icon to toggle password visibility
struct SecureTextField: View {
    
    // State variable to control password visibility
    @State private var isSecureField: Bool = true
    @Binding var text: String
    var placeholder: String // Placeholder for the password field
    
    // Body of the view
    var body: some View {
        HStack {
            if isSecureField {
                securePassField
            } else {
                normalPassField
            }
        }
        .overlay(alignment: .trailing){
            eyeIcon
        }
//        .padding(.horizontal) change later in the main content
    }
    
    //The appearance when the password is unseen by the user
    var securePassField: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
//            .clipShape(RoundedRectangle(cornerRadius: 10))
            .cornerRadius(5.0)
//            .padding(.horizontal)
    }
    
    //The appearance when the password can be seen by the user
    var normalPassField: some View {
        TextField(placeholder, text: $text)
            .padding()
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
//            .clipShape(RoundedRectangle(cornerRadius: 10))
            .cornerRadius(5.0)
//            .padding(.horizontal)

    }
    
    //The appearance of eye icon to see the password
    var eyeIcon: some View {
        Image(systemName: isSecureField ? "eye.slash" : "eye")
            .padding()
            .foregroundColor(.gray)
            .onTapGesture {
                isSecureField.toggle()
            }
    }
}

// Preview for testing the view
struct SecureTextFieldPreview: View {
    @State private var password: String = ""
    
    var body: some View {
        SecureTextField(text: $password, placeholder: "Enter password")
//            .padding()
//            .cornerRadius(10.0)
        //            .background(Color.purple.opacity(0.1))
//            .cornerRadius(10.0)
//            .padding()
    }
}

#Preview {
    SecureTextFieldPreview()
}
