//
//  MapView.swift
//  GoWhere
//
//  Created by Hang Vu on 27/9/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    // Coordinates for Yosemite National Park
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.8651, longitude: -119.5383), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    // To track the selected location's details
    @State private var selectedPlace: String? = nil
    
    // Sheet position tracking (offscreen: 500, halfway: 250, fully visible: 0)
    @State private var sheetOffset: CGFloat = 500
    
    var body: some View {
        ZStack {
            // Map displaying the region
            Map(coordinateRegion: $region, interactionModes: .all, annotationItems: locations) { location in
                // Use MapAnnotation to place a tappable marker
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image("PinIcon")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                            .onTapGesture {
                                // Show sheet and set selected place details
                                selectedPlace = location.name
                                withAnimation(.interactiveSpring()) {
                                    sheetOffset = 500 // Bring up the sheet halfway
                                }
                            }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all) // Map takes the full screen
            
            // Draggable sheet (only if a place is selected)
            if let placeName = selectedPlace {
                PlaceDetailSheetView(placeName: placeName)
                    .offset(y: sheetOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Smooth dragging down, allow sheetOffset to go below halfway
                                let newOffset = 250 + value.translation.height
                                if newOffset > 0 {
                                    sheetOffset = newOffset
                                }
                            }
                            .onEnded { value in
                                // Determine the final resting position of the sheet
                                withAnimation(.interactiveSpring()) {
                                    if value.translation.height > 200 {
                                        // If dragged significantly, dismiss the sheet
                                        self.sheetOffset = 500
                                        selectedPlace = nil // Reset selected place when dismissed
                                    } else if value.translation.height > 100 {
                                        // Rest at halfway if dragged a little
                                        self.sheetOffset = 500
                                    } else {
                                        // Fully show the sheet
                                        self.sheetOffset = 0
                                    }
                                }
                            }
                    )
                    .transition(.move(edge: .bottom)) // Transition effect
            }
        }
    }
}

import MapKit

struct CustomPinView: View {
    @State private var isSelected = false // Track whether the pin is selected

    var body: some View {
        ZStack {
            // Main pin symbol (waves icon or other)
            Image(systemName: "wave.3.forward.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
                .onTapGesture {
                    // Toggle the selected state
                    withAnimation(.spring()) {
                        isSelected.toggle()
                    }
                }

            // Small dot animation, only shown when selected
            if isSelected {
                Circle()
                    .fill(Color.white)
                    .frame(width: 10, height: 10)
                    .scaleEffect(isSelected ? 1 : 0.5)
                    .animation(.easeInOut(duration: 0.5))
                    .offset(y: 20) // Position below the main pin
            }
        }
    }
}


#Preview {
    MapView()
}
