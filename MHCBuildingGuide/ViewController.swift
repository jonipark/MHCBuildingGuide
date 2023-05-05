//
//  ViewController.swift
//  MHCBuildingGuide
//
//  Created by Joeun Park on 5/2/23.
//

import UIKit
import CoreLocation
import MapKit
import ARCL // 3rd party library

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var place: String!
    
    var sceneLocationView = SceneLocationView()
    
    lazy private var locationManger = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneLocationView.run()
        self.view.addSubview(sceneLocationView)
    
        self.title = self.place
        
        self.locationManger.delegate = self
        self.locationManger.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManger.requestAlwaysAuthorization()
        self.locationManger.startUpdatingLocation()
        
        findLocalPlaces()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = self.view.bounds
    }
    
    private func findLocalPlaces() {
        
        guard let location = self.locationManger.location else {
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = place
        
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        request.region = region
        
        // Local Search -> change it to manual search
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if error != nil {
                return
            }
            
            guard let response = response else {
                return
            }
            
            for item in response.mapItems {
                
                let placeLocation = (item.placemark.location)!
                
                let placeAnnotationNode = PlaceAnnotation(location: placeLocation, title: item.placemark.name!)

                DispatchQueue.main.async {
                    self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: placeAnnotationNode)
                }
            }
        }
    }


}

