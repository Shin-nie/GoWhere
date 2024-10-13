//
//  ContentView.swift
//  TravelAPI


//  MARK: - The Model

import Foundation

// Model to decode the API response for country info
struct CountryInfo: Codable {
    let info: String
    let image_url: String
    let country_images: [CountryImage]
}

struct CountryImage: Codable, Identifiable {
    let id = UUID() // Auto-generate a unique ID for each image
    let imageUrl: String
    let title: String
}

// Model to decode the API response for country activities
struct Activity: Codable {
    let title: String
    let activity: String
}

struct CountryActivities: Codable {
    let activities: [Activity]
}

struct ApiResponse: Codable {
    let data: CountryInfo
}

struct ActivitiesResponse: Codable {
    let data: CountryActivities
}

//  MARK: - API HANDLER/SERVICE
import Foundation

class ApiService {
    
    // Fetch country information
    func fetchCountryInfo(country: String, completion: @escaping (Result<CountryInfo, Error>) -> Void) {
        let headers = [
            "x-rapidapi-key": "3991ddde57mshc5936358b3d9c14p1a4322jsn96f993c3bb2e",
            "x-rapidapi-host": "travel-info-api.p.rapidapi.com"
        ]
        
        let urlString = "https://travel-info-api.p.rapidapi.com/country?country=\(country)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                completion(.success(apiResponse.data))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }
    
    // Fetch country activities
    func fetchCountryActivities(country: String, completion: @escaping (Result<[Activity], Error>) -> Void) {
        let headers = [
            "x-rapidapi-key": "3991ddde57mshc5936358b3d9c14p1a4322jsn96f993c3bb2e",
            "x-rapidapi-host": "travel-info-api.p.rapidapi.com"
        ]
        
        let urlString = "https://travel-info-api.p.rapidapi.com/country-activities?country=\(country)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(ActivitiesResponse.self, from: data)
                completion(.success(apiResponse.data.activities))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }
}

//  MARK: - The View
import SwiftUI

struct CountryView: View {
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
                // Search bar and button
                HStack {
                    TextField("Enter country name", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .frame(height: 44)
                    Button(action: {
                        if !searchQuery.isEmpty {
                            fetchData(for: searchQuery)
                        }
                    }) {
                        Text("Search")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.trailing)
                }
                .padding(.vertical)

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
                                .font(.title2)
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
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(Color(UIColor.systemGray6))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
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
            .navigationBarTitle("Country Info", displayMode: .inline)
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

// The view that displays the tapped image in focus
struct FocusedImageView: View {
    let image: CountryImage
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button("Close"){
                    dismiss()
                }
                
                Spacer()
            }
            
            Spacer()
            
            if let url = URL(string: image.imageUrl) {
                AsyncImage(url: url) { img in
                    img.resizable()
                        .scaledToFit()
                        .frame(maxHeight: UIScreen.main.bounds.height * 0.7)
                } placeholder: {
                    ProgressView()
                }
            }
            Text(image.title)
                .font(.headline)
                .padding(.top, 10)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
    }
}

#Preview {
    CountryView()
}
