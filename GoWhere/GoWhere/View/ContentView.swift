import SwiftUI
//
//struct ContentView: View {
//    
//    //@ObservedObject var placeVM = PlaceViewModel()
//    
//    //Hides the system tab bar across the entire application
//    //    init(){
//    //        UITabBar.appearance().isHidden = true
//    //    }
//    // MARK: - PROPERTY
//        @State private var username: String = "" // Track the username here
//        @State private var isLoggedIn: Bool = false // Track the login status
//
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Pass the username binding to TabBar
//                TabBar(username: $username)
//            }
//        }
//        //.navigationTitle("GoWhere") // Add navigation title or customize as needed
//        .onAppear {
//            UITabBar.appearance().isHidden = true // Hide the system tab bar
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTY
    @State private var username: String = "" // Track the username here
    @State private var isLoggedIn: Bool = false // Track the login status
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoggedIn {
                    // Show TabBar when logged in
                    TabBar(username: $username, isLoggedIn: $isLoggedIn)
                } else {
                    // Show LoginView when not logged in
                    LoginView(username: $username, isLoggedIn: $isLoggedIn)
                }
            }
        }
//        .onAppear {
//            UITabBar.appearance().isHidden = true // Hide the system tab bar
//        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
