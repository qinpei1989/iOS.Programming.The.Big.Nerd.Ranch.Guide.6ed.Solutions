//
//  Copyright © 2015 Big Nerd Ranch
//

/*
 * Silver Challenge: User’s Location
 */

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    var userLocationButton: UIButton!
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
        
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
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus == .notDetermined {
            CLLocationManager().requestWhenInUseAuthorization()
            return
        } else if authorizationStatus == .denied || authorizationStatus == .restricted {
            print("Unable to locate user")
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view")
    }
    
}
