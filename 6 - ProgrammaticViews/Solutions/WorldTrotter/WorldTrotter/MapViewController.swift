//
//  Copyright © 2015 Big Nerd Ranch
//

/*
 * Silver Challenge: User’s Location
 *
 * Gold Challenge: Dropping Pins
 */

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    var userLocationButton: UIButton!
    var pinButton: UIButton!
    var locationManager: CLLocationManager!
    var userLocation: CLLocation?
    var pinAnnotations = [MKAnnotation]()
    var pinAnnotationIndex = -1
    
    static let customAnnotationIdentifier = "CustomAnnotation"
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
        mapView.delegate = self
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self,
                                   action: #selector(MapViewController.mapTypeChanged(_:)),
                                   for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        /* Add a new button at the bottom right of mapView to show user's current location */
        userLocationButton = UIButton(type: .infoLight)
        userLocationButton.addTarget(self, action: #selector(updateUserLocation(_:)), for: .touchUpInside)
        /* set translatesAutoresizingMaskIntoConstraints to false if auto layout is used */
        userLocationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userLocationButton)
        let userLocationButtonBottomConstraint = userLocationButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -20)
        let userLocationButtonTrailingConstraint = userLocationButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        userLocationButtonBottomConstraint.isActive = true
        userLocationButtonTrailingConstraint.isActive = true
        
        /* Add another new button at the bottom left of mapView to show the next pin */
        pinButton = UIButton(type: .infoLight)
        pinButton.addTarget(self, action: #selector(showNextPin(_:)), for: .touchUpInside)
        pinButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinButton)
        let pinButtonBottomConstraint = pinButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -20)
        let pinButtonLeadingConstraint = pinButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        pinButtonBottomConstraint.isActive = true
        pinButtonLeadingConstraint.isActive = true
        
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    func updateUserLocation(_ button: UIButton) {
        print(#function)
        
        let authorizationStatus = checkLocationAuthorizationStatus()
        if authorizationStatus != .authorizedWhenInUse {
            return
        }
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    /*
     * Another way to show user's location is to implement setUserTrackingMode(_:animated:) in MKMapViewDelegate,
     * instead of calling setUserTrackingMode(_: animated)
     */
    /*
     func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
     let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000, 1000)
     mapView.setRegion(region, animated: true)
     }
     */
    
    func checkLocationAuthorizationStatus() -> CLAuthorizationStatus {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if locationManager == nil {
            locationManager = CLLocationManager()
        }
        if authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if authorizationStatus == .denied || authorizationStatus == .restricted {
            print("Location request is denied")
        }
        return authorizationStatus
    }
    
    func showNextPin(_ button: UIButton) {
        print(#function)
        
        /*
         * At the very beginning when current user's location is not available, only append the other two locations in the array.
         * mapView.userLocation is not reliable, so use locationManager(_:didUpdateLocations:) to get it
         */
        if userLocation == nil {
            let authorizationStatus = checkLocationAuthorizationStatus()
            if authorizationStatus != .authorizedWhenInUse {
                return
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
            pinAnnotations.append(generateCustomPinAnnotation(locationName: "Jiaozuo", latitude: 35.14, longitude: 113.13))
            pinAnnotations.append(generateCustomPinAnnotation(locationName: "New York City", latitude: 40.72, longitude: -74.00))
        }
        
        /* Remove the old pin, then drop a new pin */
        if pinAnnotationIndex >= 0 {
            let oldPinAnnotation = pinAnnotations[pinAnnotationIndex]
            mapView.removeAnnotation(oldPinAnnotation)
        }
        pinAnnotationIndex += 1
        if pinAnnotationIndex >= pinAnnotations.count {
            pinAnnotationIndex = 0
        }
        let currentPinAnnotation = pinAnnotations[pinAnnotationIndex]
        
        let region = MKCoordinateRegionMakeWithDistance(currentPinAnnotation.coordinate, 100000, 100000)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        mapView.addAnnotation(currentPinAnnotation)
    }
    
    func generateCustomPinAnnotation(locationName name: String, latitude lat: CLLocationDegrees, longitude long: CLLocationDegrees) -> MKAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate.latitude = lat
        annotation.coordinate.longitude = long
        return annotation
    }
    
    /* This method is not really needed if the pin dropping animation is unnecessary */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MapViewController.customAnnotationIdentifier)
        if annotationView == nil {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: MapViewController.customAnnotationIdentifier)
            pinView.isEnabled = true
            pinView.canShowCallout = true
            pinView.animatesDrop = true
            annotationView = pinView
        }
        return annotationView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        
        if newLocation.horizontalAccuracy < 0 {
            return;
        }
        
        if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy && userLocation == nil {
            userLocation = newLocation
            pinAnnotations.append(generateCustomPinAnnotation(locationName: "Current Location", latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude))
            locationManager.stopUpdatingLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view")
    }
    
}
