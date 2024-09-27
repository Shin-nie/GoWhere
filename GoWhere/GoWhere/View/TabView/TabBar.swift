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
    
    //  MARK: INITIALISATION
    //Hides the system tab bar across the entire application
    init(){
        UITabBar.appearance().isHidden = true
    }
    
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
            
            TravelInfoView()
                .tag("Info")
            
            //YoutubeView()
            Color(.teal)
                .tag("Youtube")
                .edgesIgnoringSafeArea(.all) // Ensure it fills the whole screen
            
            //SettingView()
            Color(.teal)
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
            TabButton(title: "Youtube", image: "play.rectangle.on.rectangle", isSelected: $current)
            Spacer(minLength: 0)
            TabButton(title: "Setting", image: "gearshape.fill", isSelected: $current)
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(Color(.systemGreen).gradient.opacity(1))
        .clipShape(Capsule())
        .padding(.horizontal, 25)
        .padding(.bottom, 10)
    }
}

//  MARK: Previews
#Preview {
    TabBar()
}
