//
//  SettingsView.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var searchText = ""
    @State private var searchRegion = MKCoordinateRegion(
        // Default location - Apple Park
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        
        NavigationView {
            
            VStack {
                
                ZStack {
                    
                    Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                        .cornerRadius(20)
                        .padding([.leading, .trailing, .bottom, .top])
                    
                    // Search bar
                    VStack {
                        
                        TextField("Search", text: $searchText, onCommit: {
                            performSearch()
                        })
                            .padding(10)
                            .background(Color(.white))
                            .cornerRadius(10)
                            .padding([.leading, .trailing, .top])
                            .padding(.top)
                            .shadow(radius: 5)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Current location button
                    VStack {
                        
                        Spacer()
                        
                        HStack {
                            
                            Spacer()
                            
                            // Centers map on user's location when pressed
                            Button(action: {
                                centerOnUserLocation()
                            }) {
                                Image(systemName: "location.fill")
                                    .padding()
                                    .shadow(radius: 5)
                                    .font(.system(size: 30))
                            }
                            .padding([.trailing, .bottom])
                        }
                    }
                }
            }
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.large)
            // Fetching current location
            .onAppear {
                locationManager.startUpdatingLocation()
            }
        }
    }

    // Stop updating current location and updating map while performing search
    private func performSearch() {
        
        locationManager.stopFollowingUser()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = searchRegion

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            let mapItems = response.mapItems
            
            if let firstItem = mapItems.first {
                let coordinate = firstItem.placemark.coordinate
                locationManager.region = MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            }
        }
    }

    // Resuming to current location
    private func centerOnUserLocation() {
        
        locationManager.startFollowingUser()
        
        if let location = locationManager.locationManager.location {
            locationManager.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}



