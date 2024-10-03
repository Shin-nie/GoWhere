//
//  SettingView.swift
//  GoWhere
//
//  Created by Hang Vu on 1/10/2024.
//

import SwiftUI

struct SettingsView: View {
    @Binding var username: String
    @State private var showChangeCredentials = false
    @State private var newUsername = ""
    @State private var newPassword = ""
    @State private var message = ""
    
    var body: some View {
        VStack {
            Text("Welcome, \(username)")
                .font(.largeTitle)
                .padding()
            
            Button(action: logOut) {
                Text("Log Out")
                    .font(.headline)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.red)
                    .cornerRadius(15.0)
                    .foregroundColor(.white)
            }
            .padding(.top, 20)
            
            Button(action: { showChangeCredentials.toggle() }) {
                Text("Change Credentials")
                    .font(.headline)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.orange)
                    .cornerRadius(15.0)
                    .foregroundColor(.white)
            }
            .padding(.top, 20)
            
            if showChangeCredentials {
                VStack {
                    TextField("New Username", text: $newUsername)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    
                    SecureField("New Password", text: $newPassword)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    
                    Button(action: changeCredentials) {
                        Text("Submit")
                            .font(.headline)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                }
            }
            
            Text(message)
                .foregroundColor(.red)
                .padding()
        }
        .padding()
        .navigationTitle("Settings")
    }
    
    // Log Out Function
    private func logOut() {
        username = ""
        message = "You have successfully logged out."
        // Navigate back to login screen
    }
    
    // Change Credentials Function
    private func changeCredentials() {
        guard !newUsername.isEmpty && !newPassword.isEmpty else {
            message = "Please fill in all fields."
            return
        }
        
        if PersistenceController.shared.updateUserCredentials(currentUsername: username, newUsername: newUsername, newPassword: newPassword) {
            message = "Credentials changed successfully!"
            username = newUsername
        } else {
            message = "Failed to change credentials."
        }
    }
}

#Preview {
    SettingsView(username: .constant("Sample User"))
}
