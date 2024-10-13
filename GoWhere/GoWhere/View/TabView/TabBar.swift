//
//  TabBar.swift
//  GoWhere
//
//  Created by Hang Vu on 25/9/2024.
//

import SwiftUI

struct TabBar: View {
    
    
    //  MARK: - PROPERTY
    @State var current = "Home"
    
    // Accept the username as a Binding
    @Binding var username: String
    @Binding var isLoggedIn: Bool // Add binding for login status

    //  MARK: INITIALISATION
    //Hides the system tab bar across the entire application
    //    init(){
    //        UITabBar.appearance().isHidden = true
    //    }
    
    //  MARK: - BODY
    var body: some View {
        ZStack {
            // TabView that extends across the entire screen
            tabView
            
            VStack {
                Spacer()
                tabButton // Tab buttons at the bottom
            }
            
        }
    }
    
    //  MARK: TabView - Navigation to each screen
    var tabView: some View {
        TabView(selection: $current) {
            HomeView()
                .tag("Home")
            
            MapView(appVM: AppViewModel())
                .tag("Info")
            
            //YoutubeView()
            VideoView()
                .tag("Video")
                .edgesIgnoringSafeArea(.all) // Ensure it fills the whole screen
            
            //SettingView() - pass the username binding to SettingsView
            SettingsView(username: $username, isLoggedIn: $isLoggedIn) // Pass isLoggedIn to SettingsView
                .tag("Setting")
        }
    }
    
    //  MARK: TabBar - The appearance of tab Buttons
    var tabButton: some View {
        HStack(spacing:0) {
            TabButton(title: "Home", image: "house", isSelected: $current)
            Spacer(minLength: 0)
            TabButton(title: "Info", image: "mappin.and.ellipse.circle.fill", isSelected: $current)
            Spacer(minLength: 0)
            TabButton(title: "Video", image: "play.rectangle.on.rectangle", isSelected: $current)
            Spacer(minLength: 0)
            TabButton(title: "Setting", image: "gearshape.fill", isSelected: $current)
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(.lightGreen.gradient.opacity(1))
        .clipShape(Capsule())
        .padding(.horizontal, 25)
        .padding(.bottom, 10)
        
        //  Shadowing depth
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
        .shadow(color: .black.opacity(0.1), radius: 1, x: 2, y:3)
    }
}

//  MARK: Previews
#Preview {
    TabBar(username: .constant("Sample User"), isLoggedIn: .constant(true))
}
