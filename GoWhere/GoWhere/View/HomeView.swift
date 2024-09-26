//
//  HomeView.swift
//  GoWhere
//
//  Created by Hang Vu on 25/9/2024.
//

import SwiftUI

struct HomeView: View {
    //  MARK: - PROPERTIES
    @State var selectedTab: Int = 0 //  Since HomeView is the parent view and should manage the tab selection state, move the @State var selectedTab to HomeView.
    // Manages the TabSelectionView ("For You", "Updated", "Saved")
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect() // Auto-scroll every 3 seconds
    
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
                
                //  MARK: Horizontal Scrollable FeaturedCardView with Dots
                TabView {
                    //  MARK: Tourist Attraction View
                    FeaturedCardView(title: "Vietnam's Secrets", subtitle: "A Wonderful Place", imageName: "GoldenBridge")
                        .tag(0)
                    FeaturedCardView(title: "Discovering Yosemite", subtitle: "California's Wonder", imageName: "Yosemite")
                        .tag(1)
                    FeaturedCardView(title: "Explore Uluru", subtitle: "Australia's Iconic Rock", imageName: "Uluru")
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))                // Creates horizontal scrolling with dots

                .frame(height: UIScreen.main.bounds.height * 0.67) // Adjusts the height based on the screen size
                .animation(.easeInOut(duration: 0.5), value: selectedTab) // Adds smooth animation when scrolling
                .onReceive(timer) { _ in
                    //  Auto-scroll between pages
                    withAnimation{
                        selectedTab = selectedTab + 1 % 3 // Automatically switch between tab
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
        }
        .navigationTitle("Home")
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
