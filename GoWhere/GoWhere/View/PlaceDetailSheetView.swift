//
//  PlaceDetailSheetView.swift
//  GoWhere

import SwiftUI

let pinkGradient = LinearGradient(
    gradient: Gradient(colors: [Color.yellow, Color.pink.opacity(0.7)]), // Gradient with opacity
    startPoint: .top,
    endPoint: .bottom
)
let blackGradient = LinearGradient(
    gradient: Gradient(colors: [Color.gray.opacity(0.7), Color.black.opacity(0.7)]), // Same color twice
    startPoint: .top,
    endPoint: .bottom
)

struct PlaceDetailSheetView: View {
    let placeName: String
    
    @State private var countryInfo: CountryInfo?
    @State private var countryActivities: [Activity] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var searchQuery = ""
    
    // State for displaying tapped image in a modal view
    @State private var selectedImage: CountryImage? = nil
    
    let apiService = ApiService()

    var body: some View {
        NavigationView {
            VStack {
                
                HeaderView()
                    .padding(.horizontal)
                
                HStack{
                    Text("Discovering \(placeName)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding()

                // Handle loading state
                if isLoading {
                    VStack {
                        ProgressView("Fetching Data...")
                            .padding()
                        Spacer()
                    }
                }
                
                // Display error message if there's an error
                else if let errorMessage = errorMessage {
                    VStack {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                        Spacer()
                    }
                }

                // Display country information if available
                else if let countryInfo = countryInfo {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // Country information section
                            Text(countryInfo.info)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            
                            // Display main image
                            if let url = URL(string: countryInfo.image_url) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(height: 200)
                                .cornerRadius(15)
                                .padding(.horizontal)
                            }

                            // Section for additional images
                            Text("Gallery")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(countryInfo.country_images) { image in
                                        VStack {
                                            if let url = URL(string: image.imageUrl) {
                                                AsyncImage(url: url) { img in
                                                    img.resizable()
                                                        .scaledToFill()
                                                        .frame(width: 150, height: 100)
                                                        .cornerRadius(10)
                                                        .clipped()
                                                        .onTapGesture {
                                                            // Set selected image and show the focused view
                                                            selectedImage = image
                                                        }
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                            }
                                            Text(image.title)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                                .frame(maxWidth: 150)
                                            
                                        }
                                        .padding(.horizontal, 5)
                                    }
                                }
                            }
                            .padding(.horizontal)

                            // Section for activities
                            if !countryActivities.isEmpty {
                                Text("Activities")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(countryActivities, id: \.title) { activity in
                                            VStack(alignment: .leading) {
                                                Text(activity.title)
                                                    .font(.subheadline)
                                                    .bold()
                                                    .padding(.bottom, 2)
                                                Text(activity.activity)
                                                    .font(.body)
                                                    .foregroundColor(.secondary)
                                            }
                                            .frame(width: 320)
                                            .padding(.horizontal)
                                            .padding(.vertical, 8)
                                            .background(Color(UIColor.systemGray6))
                                            .cornerRadius(10)
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    // Show the image in focus when tapped
                    .sheet(item: $selectedImage) { image in
                        FocusedImageView(image: image)
                    }
                } else {
                    Spacer()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .onAppear(){
                fetchData(for: placeName);
            }
        }
        
    }

    private func fetchData(for country: String) {
        isLoading = true
        errorMessage = nil
        countryInfo = nil
        countryActivities = []

        // Fetch country info
        apiService.fetchCountryInfo(country: country) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    countryInfo = data
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
        
        // Fetch country activities
        apiService.fetchCountryActivities(country: country) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let activities):
                    countryActivities = activities
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
                isLoading = false
            }
        }
    }
}

//  MARK: - Header View
struct HeaderView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isFavorite: Bool = false // Track if the button is favorited
    
    var body: some View {
        VStack {
            //  The gray capsule at the top for drag indication
            Capsule()
                .frame(width: 45, height: 6)
                .foregroundColor(Color(.systemGray3))
                .padding(.vertical, 8) // Adjust padding as needed
            
            HStack {
                
                Spacer()
                
                // Favorite Button
                FavoriteButtonView(isFavorite: $isFavorite)
            }
        }
        //.padding(.horizontal) // Padding for header
    }
}

//  MARK: - CircleButtonView
struct CircleButtonView: View {
    
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black.opacity(0.7))
                .frame(width: 44, height: 44)
                .background(Color(.systemPink).gradient.opacity(0.8))
                .clipShape(Circle())
        }
    }
}

//  MARK: - Favorite Button View
struct FavoriteButtonView: View {
    @Binding var isFavorite: Bool  //   Binding to the state of the favorite
    var body: some View {
        Button(action: {
            isFavorite.toggle() //  Toggle favorite state when button is pressed
        }) {
            Image(systemName: isFavorite ? "heart.circle.fill" : "heart.circle")
                .font(.system(size: 44, weight: .semibold))
                .foregroundStyle(isFavorite ? pinkGradient : blackGradient)
                .frame(width: 44, height: 44)
                .background(Color.white.opacity(0.85))
                .clipShape(Circle())
        }
    }
}

// MARK: - Place Title Section
struct PlaceTitleSection: View {
    let placeName: String
    let placeInfo: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Discovering \(placeName)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(placeInfo)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Photos Section
struct PhotosSectionView: View {
    let imageURLs: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.title)
                    .foregroundStyle(Color(.systemGreen).gradient.opacity(1))
                Text("Photos")
                    .font(.headline)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(imageURLs, id: \.self) { url in
                        AsyncImage(url: URL(string: url)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 200)
                                .cornerRadius(10)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                                .frame(width: 300, height: 200)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Itinerary Section
struct ItinerarySectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Itinerary")
                .font(.headline)
            
            itineraryItem(icon: "leaf.fill", title: "Mariposa Grove", description: "Largest sequoia trees grove")
            itineraryItem(icon: "mountain.2.fill", title: "Sentinel Dome", description: "Granite dome known for Jeffrey Pine")
            itineraryItem(icon: "figure.skiing.downhill", title: "Badger Ski Area", description: "Skiing area known for Jeffrey Pine")
            itineraryItem(icon: "water.waves", title: "Yosemite Falls", description: "Highest waterfall in Yosemite Park")
            
            Text("This itinerary usually takes 2-3 days. You can expand to more days if you want to take a deep tour to any of these locations.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    // Reusable itinerary item function
    func itineraryItem(icon: String, title: String, description: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(Color.green)
                .clipShape(Circle())
                .foregroundColor(.white)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

// MARK: - NotesView

struct NotesView: View {
    @State private var notes: String = "" // State to store the note text
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "note.text") // Using a note-like icon
                    .font(.system(size: 24))
                
                Text("Notes")
                    .font(.headline)
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            
            TextEditor(text: $notes)
                .frame(height: 100) // Set the height of the TextEditor
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray3), lineWidth: 1)
                )
                .padding(.horizontal) // Box inside the note
                .foregroundColor(notes.isEmpty ? Color.gray : Color.primary) // Placeholder text color
            
            if notes.isEmpty {
                Text("Your trip notes here...")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 26)
                    .padding(.top, -100) // Adjust this value based on your TextEditor height
                    .allowsHitTesting(false) // Make it unclickable
            }
        }
        .padding(.vertical, 15)
        .background(Color(.systemPink).gradient.opacity(0.8))
        .cornerRadius(12)
    }
}

//  MARK: - PlaceDetailSheetView
#Preview {
    PlaceDetailSheetView(placeName: "Vietnam")
}
