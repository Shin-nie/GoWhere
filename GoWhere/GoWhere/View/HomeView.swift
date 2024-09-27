//
//  HomeView.swift
//  GoWhere
//
//  Created by Hang Vu on 25/9/2024.
//

import SwiftUI

struct HomeView: View {
    //  MARK: - PROPERTIES
    
    @State private var selectedFeaturedTab: Int = 0 // Manages the horizontal card scrolling (TabView of FeaturedCardView)
    
    @State var selectedTab: Int = 0 //  Since HomeView is the parent view and should manage the tab selection state, move the @State var selectedTab to HomeView. 
    // Manages the TabSelectionView ("For You", "Updated", "Saved")
    
    let timer = Timer.publish(every: 4.5, on: .main, in: .common).autoconnect() // Auto-scroll every 3 seconds
    
    init() {
        // Make the page indicator dots dark
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.3) // Lighter color for inactive dots
    }
    
    //  MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 16) {
                //  MARK: Search Bar View
                SearchBarView(text: .constant(""), placeholder: "Search for places")
                
                //  MARK: Horizontal Scrollable FeaturedCardView with Dots and 3D Effect
                TabView(selection: $selectedFeaturedTab) {
                    ForEach(0..<3) { index in
                        
                        //  MARK: Use GeometryReader to calculate the position of each card and apply rotation and scaling based on the card’s position relative to the viewport.
                        GeometryReader { geo in
                            //  MARK: Tourist Attraction View
                            FeaturedCardView(title: getTitle(for: index), subtitle: getSubtitle(for: index), imageName: getImage(for: index))
                            
                                .offset(x: -5)
                            
                            //  MARK: 3D EFFECT
                                .rotation3DEffect(
                                    Angle(degrees: Double(geo.frame(in: .global).minX - 30) / -20), // Rotation based on scroll position
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .scaleEffect(
                                    1 - abs(geo.frame(in: .global).minX) / 600 // Scale based on the scroll position
                                )
//                                .padding(.vertical, 40) // Add padding to create space between cards
                        }
                        .tag(index)
                    }
                }
                //  MARK: TAB View Design
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // Creates horizontal scrolling with dots
                
                .frame(height: UIScreen.main.bounds.height * 0.62) // Adjusts the height based on the screen size
                
                //  MARK: - ANIMATION ADDING (Auto-Scrolling)
                .animation(.spring(duration: 1000), value: selectedFeaturedTab) // Adds smooth animation when scrolling
                .onReceive(timer) { _ in
                    //  Auto-scroll between pages
                    withAnimation{
                        selectedFeaturedTab = (selectedFeaturedTab + 1) % 3 // Automatically switch between tab - then Loop back to the first tab
                        //  MARK: This ensures that when selectedFeaturedTab reaches 2 (the last tab), the next increment will loop it back to 0
                    }
                }
                
                //  MARK: Tab View
                TabSelectionView(selectedTab: $selectedTab)
                //  Conditionally show SampleCardView based on the selected tab
                if selectedTab == 0 {
                    //  MARK: Sample Card under Tab
                    SampleCardView(title: "Explore Uluru", description: "A unique blend of culture, cuisine and nature. Perfect for foodies and wine enthusiasts.", imageName: "Uluru")
                } else if selectedTab == 1 {
                    SampleCardView(
                        title: "Explore Sonoma",
                        description: "A unique blend of culture, cuisine and nature. Perfect for foodies and wine enthusiasts.",
                        imageName: "Yosemite" )
                } else if selectedTab == 2 {
                    SampleCardView(title: "Explore Golden Bridge", description: "A unique blend of culture, cuisine and nature. Perfect for foodies and wine enthusiasts.", imageName: "GoldenBridge")
                }
            }
            .padding(.horizontal)
            
            //  MARK: - ANIMATION ADDING
            //            .animation(.easeInOut(duration: 0.5), value: selectedTab) // Adds smooth animation when scrolling
            //            .onReceive(timer) { _ in
            //                //  Auto-scroll between pages
            //                withAnimation{
            //                    selectedTab = (selectedTab + 1) % 3 // Automatically switch between tab
            //                }
            //            }
        }
//        .ignoresSafeArea(.all, edges: .bottom) // Ignore the bottom safe area to prevent the white frame from appearing
        .navigationTitle("Home")
    }
    
    //  MARK: - Helper functions for titles and images
    private func getTitle(for index: Int) -> String {
        switch index {
        case 0: return "Vietnam's Secrets"
        case 1: return "Discovering Yosemite"
        case 2: return "Explore Uluru"
        default: return ""
        }
    }
    
    private func getSubtitle(for index: Int) -> String {
        switch index {
        case 0: return "A Wonderful Place"
        case 1: return "California's Wonder"
        case 2: return "Australia's Iconic Rock"
        default: return ""
        }
    }
    
    private func getImage(for index: Int) -> String {
        switch index {
        case 0: return "GoldenBridge"
        case 1: return "Yosemite"
        case 2: return "Uluru"
        default: return ""
        }
    }
}


//  MARK: - Sub-View
//  MARK: Search Bar View
struct SearchBarView: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .padding(.leading, 24)
            .frame(height: 50)
            .background(Color(.systemGray6))
        //.background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    Spacer()
                }
            )
        //                    .padding()
    }
}

//  MARK: - Featured Card View
struct FeaturedCardView: View {
    var title: String
    var subtitle: String
    var imageName: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Background Image with a slight blur effect to add depth
            Image(imageName)
                .resizable()
                .scaledToFill()
            //                .frame(width: 420, height: 480)
                .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.55) // Makes it more responsive
                .cornerRadius(20)
                .clipped()
            
            // Title and subtitle in the overlay at the bottom
            VStack(alignment: .center, spacing: 8) {
                Text(title)
                    .font(.largeTitle) // Increased font size for a more impactful title
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 4) // Soft shadow for text
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.top, 2)
            }
            .padding(.vertical, 24) // Adds more padding to make the text stand out
            .frame(maxWidth: .infinity, alignment: .center)
            // Overlay gradient with subtle animation for a modern effect
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.85)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .cornerRadius(20)
                .blur(radius: 1) // Adds a touch of blur for smoothness
            )
        }
        // Enhanced shadow effects for better depth
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}

//  MARK: - Tab Selection View
struct TabSelectionView: View {
    @Binding var selectedTab: Int //    Pass the selectedTab from HomeView to TabSelectionView as a Binding.
    let tabs = ["For You", "Updated", "Saved"]
    
    var body: some View {
        Picker("", selection: $selectedTab) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Text(tabs[index])
                    .tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .background(Color.white)
        .cornerRadius(8)
    }
}

// MARK: - Sample Card View
struct SampleCardView: View {
    var title: String
    var description: String
    var imageName: String
    
    var body: some View {
        HStack {
            Image(imageName)
            //                 .resizable()
            //                 .aspectRatio(contentMode: .fill)
            //                 .frame(width: 80, height: 80)
            //                 .cornerRadius(8)
                .resizable()
                .scaledToFill()
                .frame(width: 140)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .shadow(color: .black.opacity(0.1), radius: 1, x: 2, y:5)
    }
}

//  MARK: - PREVIEWS
#Preview {
    HomeView()
}
