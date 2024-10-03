//
//  LoginView.swift
//  GoWhere
//
//  Created by Hang Vu on 3/10/2024.
//
import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var message = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if !isLoggedIn {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    
                    SecureTextField(text: $password, placeholder: "Password")
                        .padding(.bottom, 20)
                    
                    Button(action: signUp) {
                        Text("Sign Up")
                            .font(.headline)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.green)
                            .cornerRadius(15.0)
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 10)
                    
                    Button(action: login) {
                        Text("Login")
                            .font(.headline)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 10)
                    
                    Text(message)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Continue as guest without login
                NavigationLink(destination: ContentView()) {
                    Text("Continue as Guest")
                        .font(.headline)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.gray)
                        .cornerRadius(15.0)
                        .foregroundColor(.white)
                }
                .padding(.top, 10)
                .navigationBarBackButtonHidden()
                
                //After login, navigate to TabBar
//                NavigationLink(destination: TabBar(username: $username, isLoggedIn: $isLoggedIn), isActive: $isLoggedIn) {
//                    EmptyView()
//                }
                
                // NavigationLink to SettingsView, activated by isLoggedIn
                NavigationLink(destination: ContentView(), isActive: $isLoggedIn) {
                    EmptyView() // This ensures the navigation happens automatically
                }
            }
            .padding()
            .navigationTitle("Login/Sign Up")
        }
    }
    
    // Sign Up Function
    private func signUp() {
        guard !username.isEmpty && !password.isEmpty else {
            message = "Please fill in all fields."
            return
        }
        
        if PersistenceController.shared.fetchUser(username: username) == nil {
            PersistenceController.shared.saveUser(username: username, password: password)
            message = "Sign up successful!"
        } else {
            message = "Username already exists."
        }
    }
    
    // Login Function
    private func login() {
        guard !username.isEmpty && !password.isEmpty else {
            message = "Please fill in all fields."
            return
        }
        
        if let user = PersistenceController.shared.fetchUser(username: username) {
            if user.pwd == password {
                isLoggedIn = true
                message = "Login successful!"
            } else {
                message = "Incorrect password."
            }
        } else {
            message = "User not found."
        }
    }
}

#Preview {
    LoginView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
