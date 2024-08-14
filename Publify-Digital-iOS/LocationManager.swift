//
//  LocationManager.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // Current issues - "Publishing changes from within view updates is not allowed, this will cause undefined behavior."
    // Not critical, however currently not sure how to fix it
    var locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(
        // Default location
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    // Flag to control whether location updates should affect the region
    var shouldFollowUser = true
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard shouldFollowUser, let location = locations.first else { return }
        region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
    
    func getCurrentLocation() -> CLLocationCoordinate2D? {
        return locationManager.location?.coordinate
    }
    
    func stopFollowingUser() {
        shouldFollowUser = false
    }
    
    func startFollowingUser() {
        shouldFollowUser = true
    }
}


