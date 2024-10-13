//
//  MapView.swift
//  GoWhere
import SwiftUI
import MapKit

struct MapView: View {
    //  PROPERTIES
    @ObservedObject var appVM: AppViewModel;
    @State var countryAPI = CountryManager();
    
    @State var countryList: [Country] = [];
    @State var countryLocation: [Location] = [];
    
    // Coordinates for Yosemite National Park
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.8651, longitude: -119.5383), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    // To track the selected location's details
    @State private var selectedPlace: String? = nil
    
    // Sheet position tracking (offscreen: 500, halfway: 250, fully visible: 0)
    @State private var sheetOffset: CGFloat = 500
    
    var initialCountry: String?
    
    init(appVM: AppViewModel, initialCountry: String? = nil) {
        self.appVM = appVM
        self.initialCountry = initialCountry
        
        // Fetch ALL countries when MapView is initialized
        countryAPI.fetchAllCountries()
    }
    
    var body: some View {
        ZStack {
            
            // Map displaying the region
            MapReader { mapReader in
                Map(position: $appVM.mapCameraPosition) {
                    ForEach(countryList) { country in
                        //  GET Country Location
                        let location =  CLLocationCoordinate2D(latitude: country.latlng[0], longitude: country.latlng[1])
                        
                        Annotation("\(country.name.common)", coordinate: location){
                            Button{
                                // Show sheet and set selected place details
                                selectedPlace = country.name.common
                                withAnimation(.interactiveSpring()) {
                                    sheetOffset = 50 // Bring up the sheet
                                }
                            } label:{
                                Image("PinIcon")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .offset(y: -10)
                            }
                        }
                        
                        
                    }
                }
            }
            
            // Draggable sheet (only if a place is selected)
            if let placeName = selectedPlace {
                PlaceDetailSheetView(placeName: placeName)
                    .offset(y: sheetOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Smooth dragging down, allow sheetOffset to go below halfway
                                let newOffset = 50 + value.translation.height
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
                                    }
                                    else {
                                        // Fully show the sheet
                                        self.sheetOffset = 50
                                    }
                                }
                            }
                    )
                    .transition(.move(edge: .bottom)) // Transition effect
            }
            
        }
        //  Pull Country
        .onReceive(countryAPI.$countriesList) { countryData in
            if let safeCountryData = countryData {
                countryList = safeCountryData;
                
                // Automatically center on the initial country if provided
                if let initialCountry = initialCountry, let country = countryList.first(where: { $0.name.common == initialCountry }) {
                    setRegionForCountry(country) // Center the map on the selected country
                    selectedPlace = initialCountry // Automatically show PlaceDetailSheetView
                    withAnimation(.interactiveSpring()) {
                        sheetOffset = 50 // Show the sheet
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Function to Set Region
         func setRegionForCountry(_ country: Country) {
            let location = CLLocationCoordinate2D(latitude: country.latlng[0], longitude: country.latlng[1])
            region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
}

//    .onTapGesture {
//        // Show sheet and set selected place details
//        selectedPlace = location.name
//        withAnimation(.interactiveSpring()) {
//            sheetOffset = 500 // Bring up the sheet halfway
//        }
//    }

//struct CustomPinView: View {
//    @State private var isSelected = false // Track whether the pin is selected
//
//    var body: some View {
//        ZStack {
//            // Main pin symbol (waves icon or other)
//            Image(systemName: "wave.3.forward.circle.fill")
//                .resizable()
//                .frame(width: 30, height: 30)
//                .foregroundColor(.blue)
//                .onTapGesture {
//                    // Toggle the selected state
//                    withAnimation(.spring()) {
//                        isSelected.toggle()
//                    }
//                }
//
//            // Small dot animation, only shown when selected
//            if isSelected {
//                Circle()
//                    .fill(Color.white)
//                    .frame(width: 10, height: 10)
//                    .scaleEffect(isSelected ? 1 : 0.5)
//                    .animation(.easeInOut(duration: 0.5))
//                    .offset(y: 20) // Position below the main pin
//            }
//        }
//    }
//}


#Preview {
    MapView(appVM: AppViewModel())
}
