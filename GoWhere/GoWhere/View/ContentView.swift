import SwiftUI

struct ContentView: View {
    
    //@ObservedObject var placeVM = PlaceViewModel()
    
    //Hides the system tab bar across the entire application
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TabBar() // Add TabBar view here
            }
        }
        //.navigationTitle("GoWhere") // Add navigation title or customize as needed
    }
}

#Preview {
    ContentView()
}
