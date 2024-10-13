import SwiftUI
import WebKit

// This struct is for embedding YouTube videos
struct VideoViewRepresentable: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedURLString = "https://www.youtube.com/embed/\(videoID)"
        guard let url = URL(string: embedURLString) else { return }
        uiView.load(URLRequest(url: url))
    }
}

// The main view that shows the videos
struct VideoView: View {
    @State private var videoIDs: [String] = []
    @State private var isLoading: Bool = true
    @State private var searchQuery: String = "travel destination" // Default search query

    var body: some View {
        NavigationView {
            VStack {
                // Search bar at the top
                HStack {
                    TextField("Search videos...", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .frame(height: 44)

                    Button(action: {
                        // Fetch videos when the search button is pressed
                        fetchYouTubeVideos()
                    }) {
                        Text("Search")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.green.gradient)
                            .cornerRadius(10)
                    }
                    .padding(.trailing)
                }

                // Loading or video list
                if isLoading {
                    ProgressView("Loading videos...")
                } else if videoIDs.isEmpty {
                    Text("No videos found")
                } else {
                    List(videoIDs, id: \.self) { videoID in
                        VStack(alignment: .leading) {
                            // Embedding YouTube video using WKWebView
                            VideoViewRepresentable(videoID: videoID)
                                .frame(height: 300)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding(.bottom, 10)
                        }
                    }
                    .navigationTitle("YouTube Videos")
                }
            }
            .onAppear {
                fetchYouTubeVideos()
            }
        }
    }
    
    // This function fetches YouTube videos based on the search query
    func fetchYouTubeVideos() {
        let apiKey = "AIzaSyDM5EfOGlqDmg2cL3d08FQhsQkFPKTYeQo"  // Your actual API key
        let urlEncodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let searchUrlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=5&q=\(urlEncodedQuery)&type=video&key=\(apiKey)"
        
        guard let searchUrl = URL(string: searchUrlString) else {
            return
        }
        
        isLoading = true // Set loading state to true before fetching
        
        // First API call: Fetch video IDs from search results
        URLSession.shared.dataTask(with: searchUrl) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    isLoading = false
                }
                print("Error fetching videos: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                // Parse the JSON response from YouTube API
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let items = json["items"] as? [[String: Any]] {
                    
                    let videoIDs = items.compactMap { item -> String? in
                        if let id = item["id"] as? [String: Any], let videoID = id["videoId"] as? String {
                            return videoID
                        }
                        return nil
                    }
                    
                    // After fetching video IDs, fetch details about those videos
                    fetchVideoDetails(for: videoIDs)
                }
            } catch {
                DispatchQueue.main.async {
                    isLoading = false
                }
                print("Error parsing JSON: \(error)")
            }
        }.resume()
    }
    
    // This function fetches video details to check if the videos are embeddable
    func fetchVideoDetails(for videoIDs: [String]) {
        let apiKey = "AIzaSyDM5EfOGlqDmg2cL3d08FQhsQkFPKTYeQo"  // Your actual API key
        let videoIDsString = videoIDs.joined(separator: ",")
        let videosUrlString = "https://www.googleapis.com/youtube/v3/videos?part=contentDetails,status&id=\(videoIDsString)&key=\(apiKey)"
        
        guard let videosUrl = URL(string: videosUrlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: videosUrl) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    isLoading = false
                }
                print("Error fetching video details: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                // Parse the JSON response from YouTube API
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let items = json["items"] as? [[String: Any]] {
                    
                    DispatchQueue.main.async {
                        self.videoIDs = items.compactMap { item in
                            if let id = item["id"] as? String,
                               let status = item["status"] as? [String: Any],
                               let embeddable = status["embeddable"] as? Bool, embeddable == true {
                                return id // Only add the video if it's embeddable
                            }
                            return nil
                        }
                        self.isLoading = false
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    isLoading = false
                }
                print("Error parsing video details JSON: \(error)")
            }
        }.resume()
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
