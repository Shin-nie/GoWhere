//
//  SettingView.swift
//  GoWhere
//
//  Created by Hang Vu on 1/10/2024.
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    @Published var profileImage: UIImage? = UIImage(systemName: "person.circle.fill")
    @Published var username: String = ""
    @Published var email: String = ""

    // Placeholder logout functionality
    func logOut() {
        print("User logged out.")
        // Implement actual logout logic, e.g., clearing session data or redirecting to login
    }
}

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Image
                ProfileImageView(image: viewModel.profileImage)
                    .onTapGesture {
                        self.showImagePicker = true
                    }
                
                Text("Tap to change profile image")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                // User Credentials
                CredentialsView(username: $viewModel.username, email: $viewModel.email)
                    .padding(.horizontal, 20)
                
                // Log Out Button
                Button(action: {
                    viewModel.logOut()
                }) {
                    Text("Log Out")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
    }
    
    // Load selected image and update ViewModel
    func loadImage() {
        guard let inputImage = inputImage else { return }
        viewModel.profileImage = inputImage
    }
}

struct ProfileImageView: View {
    var image: UIImage?
    
    var body: some View {
        Image(uiImage: image ?? UIImage(systemName: "person.circle.fill")!)
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            .shadow(radius: 10)
            .padding(.top, 20)
    }
}

struct CredentialsView: View {
    @Binding var username: String
    @Binding var email: String
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Username", text: $username)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
        }
    }
}

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    // Coordinator to handle UIImagePickerControllerDelegate functions
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        // Called when an image is picked
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        // Called when the user cancels picking an image
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    // Specify that the UIViewControllerType is UIImagePickerController
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Creates the UIImagePickerController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        // Assign the coordinator as the delegate
        picker.delegate = context.coordinator
        return picker
    }

    // Updates the UIImagePickerController
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No update logic needed in this case
    }

    // Specify the UIViewControllerType
    typealias UIViewControllerType = UIImagePickerController
}


#Preview {
    SettingsView()
}
