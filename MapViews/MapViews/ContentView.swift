import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -30.5595, longitude: 22.9375), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    @State private var searchText = ""
    @State private var searchCategory = SearchCategory.places
    @State private var searchItems: [MKMapItem] = []
    @State private var showSearchResults = false
    @State private var locationManager = CLLocationManager()
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: searchItems) { item in
                MapPin(coordinate: item.placemark.coordinate, tint: .red)
            }
            .edgesIgnoringSafeArea(.all)
            
            Picker("Search Category", selection: $searchCategory) {
                ForEach(SearchCategory.allCases, id: \.self) { category in
                    Text(category.rawValue.capitalized).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            TextField("Search", text: $searchText, onCommit: search)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()
            
            if showSearchResults {
                List {
                    ForEach(searchItems) { item in
                        Text(item.name ?? "Unknown")
                            .onTapGesture {
                                region.center = item.placemark.coordinate
                                showSearchResults = false
                            }
                    }
                }
                .frame(height: 200)
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .padding()
            }
        }
        .onAppear {
            locationManager.delegate = makeCoordinator()
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    private func search() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            searchItems = response.mapItems
            showSearchResults = true
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, CLLocationManagerDelegate {
        var parent: ContentView
        
        init(_ parent: ContentView) {
            self.parent = parent
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            parent.region.center = location.coordinate
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            if manager.authorizationStatus == .authorizedWhenInUse {
                manager.startUpdatingLocation()
            }
        }
    }
}

enum SearchCategory: String, CaseIterable {
    case places = "places"
    case landmarks = "landmarks"
    case restaurants = "restaurants"
}

extension MKMapItem: Identifiable {
    public var id: String {
        return name ?? UUID().uuidString
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
