//
//  HomeView.swift
//  GoWhere

import SwiftUI

struct HomeView: View {
    @State var countryAPI: CountryManager = CountryManager();
    @State private var displayList: [Country] = [];
    @State private var searchString: String = "";
    
    // MARK: - Navigation Link to MapView
    @State private var selectedCountry: String? = nil // Track selected country
    
    var filteredList: [Country] {
        if searchString.isEmpty {
            return displayList
        } else {
            return displayList.filter { country in
                country.name.common.localizedCaseInsensitiveContains(searchString)
            }
        }
    }
    
    //  MARK: - PROPERTIES
    //  @State var selectedTab: Int = 0
    //  Manages the TabSelectionView ("For You", "Updated", "Saved")
    @StateObject var viewModel = PlaceViewModel()
    
    @StateObject var featuredViewModel = FeaturedCardViewModel() // ViewModel for FeaturedCardView
    
    // Sheet position tracking (offscreen: 500, halfway: 250, fully visible: 0)
    @State private var sheetOffset: CGFloat = 50
    
    let timer = Timer.publish(every: 4.5, on: .main, in: .common).autoconnect() // Auto-scroll timer - every 4.5 seconds
    
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
                SearchBarView(text: $searchString, placeholder: "Search for places")
                
                //  MARK: Horizontal Scrollable FeaturedCardView with Dots and 3D Effect
                TabView(selection: $featuredViewModel.selectedFeaturedTab) {
                    ForEach(Array(featuredViewModel.featuredPlaces.enumerated()), id: \.1.title) { index, featuredPlace in
                        
                        //  MARK: Use GeometryReader to calculate the position of each card and apply rotation and scaling based on the card’s position relative to the viewport.
                        GeometryReader { geo in
                            //  MARK: Tourist Attraction View
                            FeaturedCardView(featuredPlace: featuredViewModel.getFeaturedPlace(for: index))
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
                
                .frame(height: UIScreen.main.bounds.height * 0.61) // Adjusts the height based on the screen size
                
                //  MARK: - ANIMATION ADDING (Auto-Scrolling)
                .animation(.spring(duration: 1000), value: featuredViewModel.selectedFeaturedTab) // Adds smooth animation when scrolling
                .onReceive(timer) { _ in
                    //  Auto-scroll between pages
                    withAnimation{
                        featuredViewModel.incrementSelectedTab() // Automatically switch between tab - then Loop back to the first tab
                        //  MARK: This ensures that when selectedFeaturedTab reaches 2 (the last tab), the next increment will loop it back to 0
                    }
                }
                
                //  MARK: - Tab View
                //                TabSelectionView(selectedTab: $viewModel.selectedTab)
                .offset(y: -10)
                //  Conditionally show SampleCardView based on the selected tab
                // MARK: Place Card under Tab - Dynamically loaded via ViewModel
                ForEach(filteredList) { current in
                    ZStack {
                        // NavigationLink to handle the navigation to MapView
                        NavigationLink(
                            destination: MapView(appVM: AppViewModel(), initialCountry: current.name.common),
                            tag: current.name.common,
                            selection: $selectedCountry
                        ) {
                            EmptyView() // Invisible but handles navigation
                        }
                        .hidden() // Hides the NavigationLink but keeps it functional

                        // Foreground view that user interacts with
                        PlaceCardView(country: current)
                            .onTapGesture {
                                print(current.name.common)
                                selectedCountry = current.name.common // Trigger the navigation
                            }
                    }
                }
            }
            .padding(.horizontal)
            //  MARK: - ANIMATION ADDING (auto-scrolling)
            //            .animation(.easeInOut(duration: 0.5), value: selectedTab) // Adds smooth animation when scrolling
            //            .onReceive(timer) { _ in
            //                //  Auto-scroll between pages
            //                withAnimation{
            //                    selectedTab = (selectedTab + 1) % 3 // Automatically switch between tab
            //                }
            //            }
        }
        .onAppear {
            UITabBar.appearance().isHidden = true // Hide the system tab bar
            countryAPI.fetchAllCountries();
        }
        .onReceive(countryAPI.$countriesList) { countryData in
            if let safeCountryData = countryData{
                displayList = safeCountryData;
            }
        }
        //  .ignoresSafeArea(.all, edges: .bottom) // Ignore the bottom safe area to prevent the white frame from appearing
        .navigationTitle("Explore Places")
    }
    
    // MARK: - Reusable Divider
    var divider: some View {
        VStack {}
            .frame(width: 360, height: 0.6)
            .background(Color(hex: 0xaeaeb2))
            .padding(.vertical, 15)
        //            .padding()
    }
}


//  MARK: - Sub-View
//  MARK: Search Bar View
struct SearchBarView: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.gray.opacity(1)) // Adjusting the icon color
                    .padding(.horizontal, 8)
                
                TextField(placeholder, text: $text)
                    .foregroundStyle(.black)
                
            }
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 20.0)
                        .fill(.lightGreen.gradient.opacity(1)) // Background color with gradient
                        .frame(height: 45)
                    // INNER SHADOW (for TextField)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 4) // Border color and width
                        .blur(radius: 2.5) // Soft shadow effect
                        .offset(x: 0, y: 2) // Shadow offset
                        .mask(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear]), startPoint: .top, endPoint: .bottom)
                                )
                        )
                }
            }
            .padding(.horizontal, 15) // Horizontal Padding of whole search bar
        }
        .padding(.vertical) // Adjust outer padding
    }
    
}

//  MARK: - Featured Card View
struct FeaturedCardView: View {
    //    var title: String
    //    var subtitle: String
    //    var imageName: String
    var featuredPlace: FeaturedPlace // Use protocol-based data
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            //  Background Image with a slight blur effect to add depth
            Image(featuredPlace.imageName)
                .resizable()
                .scaledToFill()
            //  .frame(width: 420, height: 480)
                .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.55) // Makes it more responsive
                .cornerRadius(20)
                .clipped()
            
            // Title and subtitle in the overlay at the bottom
            VStack(alignment: .center, spacing: 8) {
                Text(featuredPlace.title)
                    .font(.largeTitle) // Increased font size for a more impactful title
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 4) // Soft shadow for text
                
                Text(featuredPlace.subtitle)
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
struct PlaceCardView: View {
    //    var title: String
    //    var description: String
    //    var imageName: String
    var country: Country // Use protocol-based data
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: country.flags.png)){ image in
                image.resizable();
            } placeholder: {
                Color.gray;
            }
            .border(.gray)
            .frame(width: 55, height: 38)
            
            Text("\(country.name.common)")
                .font(.custom("MontserratAlternates-SemiBold", size: 20))
                .tracking(2)
                .padding(.horizontal, 10);
            
            Spacer();
        }
        .padding(.horizontal)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .shadow(color: .black.opacity(0.1), radius: 1, x: 2, y:5)
        )
        //  PADDING Around Button
        .padding(.vertical, 3)
    }
}

//  MARK: - PREVIEWS
#Preview {
    HomeView()
}
