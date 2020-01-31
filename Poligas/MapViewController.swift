//
//  MapViewController.swift
//  Poligas
//
//  Created by Alex Arevalo on 1/17/20.
//  Copyright © 2020 Quantum. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()//Nos ayuda a gestion ubicaciones del mapa
    let firestore = Firestore.firestore()
    var locationPin : CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        centerMapIn(location: locationManager.location)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations[locations.count - 1].coordinate
        let lat = lastLocation.latitude.description
        let long = lastLocation.longitude.description
        
        firestore.collection("location").document("test").setData(["coordinates": [lat, long] ]){(error) in
            if error != nil{
                self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            }}
        
        mapView.mapType = MKMapType.standard
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = lastLocation
        annotation.title = "Poli-Gas"
        annotation.subtitle = "current location"
        mapView.addAnnotation(annotation)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")

            pinAnnotationView.pinTintColor = .blue
            pinAnnotationView.isDraggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true

            return pinAnnotationView
        }

        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView pinAnnotation: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        
        
        
        //let coordinate : CLLocation = pinAnnotation.annotation?.coordinate
        
        //print("Coordiante", coordinate)
        
        let coordinates = CLLocation(latitude: pinAnnotation.annotation?.coordinate.latitude ?? 0, longitude: pinAnnotation.annotation?.coordinate.longitude ?? 0)
        
        //centerMapIn(location: center)
        
        //print("Coordiante", center)
        
        locationPin = coordinates
        //centerMapIn(location: pinAnnotation.annotation?.coordinate as CLLocation)
        
        
        
        
        //centerMapIn(location: view.coordinateSpace.convert(CLLocation, from: UICoordinateSpace))
    }
    
    

    
    
    func showAlert(title : String, message : String){
        let alertController = UIAlertController(title : title, message : message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAlertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func centerMapIn(location: CLLocation?) {
        
        guard let location = location else {
            return
        }
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func centerLocationPressed(_ sender: Any) {
        if(locationPin != nil){
            centerMapIn(location: locationPin)
        }else{
            centerMapIn(location: locationManager.location)
        }
        
    }
    
    
}
