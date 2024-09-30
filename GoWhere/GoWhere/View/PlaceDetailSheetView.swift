//
//  PlaceDetailSheetView.swift
//  GoWhere
//
//  Created by Hang Vu on 30/9/2024.
//

import SwiftUI

// Sample image URLs
let sampleImageURLs3 = [
    "https://images.unsplash.com/photo-1431794062232-2a99a5431c6c",
    "https://images.unsplash.com/photo-1465256410760-10640339c72c",
    "https://images.unsplash.com/photo-1633466858898-a51e5fa02c91",
    "https://images.unsplash.com/photo-1498855592392-af2bf1e0a4c7",
    "https://images.unsplash.com/photo-1604542031658-5799ca5d7936"
]

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
    
    var placeName: String
    
    var body: some View {
        VStack {
            //  The gray capsule at the top for drag indication
            Capsule()
                .frame(width: 45, height: 6)
                .foregroundColor(Color(.systemGray3))
                .padding(.top, -8) // Adjust padding as needed
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 16) {
                    // Header with back and favorite buttons
                    HeaderView()
                    
                    // Discovering title section
                    PlaceTitleSection(placeName: placeName)
                    
                    // Photos section
                    PhotosSectionView(imageURLs: sampleImageURLs3)
                    
                    // Itinerary Section
                    ItinerarySectionView()
                    
                    // Note Section
                    NotesView()
                    
                    Spacer() // Push content up to make space at the bottom
                    
                }
                .padding(.horizontal) // Apply horizontal padding to the entire VStack
            }
        }// End Of VStack
        //  The View of the Sheet
        .padding(.top, 16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .ignoresSafeArea(edges: .bottom)
    }
}

//  MARK: - Header View
struct HeaderView: View {
    @State private var isFavorite: Bool = false // Track if the button is favorited
    
    var body: some View {
        HStack {
            //  Back Button
            CircleButtonView(icon: "chevron.down", action: {})
            
            Spacer()
            
            // Favorite Button
            FavoriteButtonView(isFavorite: $isFavorite)
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
            Image(systemName: icon)
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Discovering \(placeName)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Yosemite National Park is in California’s Sierra Nevada mountains. It’s famed for its giant, ancient sequoia trees.")
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
    PlaceDetailSheetView(placeName: "Yosemite")
}
