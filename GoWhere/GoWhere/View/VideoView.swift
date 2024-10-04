//
//  VideoView.swift
//  GoWhere
//
//  Created by Hang Vu on 1/10/2024.
//

import SwiftUI
import WebKit

// A reusable component to show an individual YouTube video
struct VideoViewRepresentable: UIViewRepresentable {
    let videoID: String
    
    // Create the WKWebView
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    // Load the YouTube video in WKWebView
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedURLString = "https://www.youtube.com/embed/\(videoID)"
        guard let url = URL(string: embedURLString) else { return }
        
        uiView.load(URLRequest(url: url))
    }
}

// Main view to show a list of videos
struct VideoView: View {
    
    @State var text: String = ""
    
    // Array of video IDs
    let videoIDs = [
        "hVFp1T_2TzY", // Iceland 4K Travel
        "5bsO58DpXLU", // Japan Top 10
        "b_Xzxxs81mE", // Best Travel Destinations 2024
        "VRhr5ybpDIo"  // Solo Travel Guide
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            
            NavigationView {
                List(videoIDs, id: \.self) { videoID in
                    VStack(alignment: .leading) {
                        Text("Video ID: \(videoID)")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        // Show the video using the reusable VideoViewRepresentable
                        VideoViewRepresentable(videoID: videoID)
                            .frame(height: 300)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.vertical, 10)
                }
                //.navigationTitle("YouTube Videos")
            }
            
//            SearchBarView(text: $text, placeholder: "Search for Videos")
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
