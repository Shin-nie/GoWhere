//
//  MapView.swift
//  GoWhere
//
//  Created by Hang Vu on 27/9/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    // Define a region with center coordinates and span (zoom level)
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // San Francisco coordinates
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
            Map(coordinateRegion: $region)
                .ignoresSafeArea(edges: .all) // Optional to make the map full screen
    }
}

#Preview {
    MapView()
}
