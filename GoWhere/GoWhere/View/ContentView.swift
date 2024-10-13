import SwiftUI
struct ContentView: View {
    // MARK: - PROPERTY
    @State private var username: String = "" // Track the username here
    @State private var isLoggedIn: Bool = false // Track the login status
    @State private var isGuest: Bool = false // Track if the user is a guest
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoggedIn || isGuest {
                    // Show TabBar when logged in or guest
                    TabBar(username: $username, isLoggedIn: $isLoggedIn)
                } else {
                    // Show LoginView when not logged in or guest
                    LoginView(username: $username, isLoggedIn: $isLoggedIn, isGuest: $isGuest)
                }
            }
        }
        //        .onAppear {
        //            UITabBar.appearance().isHidden = true // Hide the system tab bar
        //        }
    }
}

extension Color {
    init(hex: Int, alpha: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}

