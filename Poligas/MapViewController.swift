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
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var mapView: MKMapView!
    let firestore = Firestore.firestore()
    var locationPin : CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        let annotation = MKPointAnnotation()
        let coordinates = CLLocationCoordinate2D(latitude: -0.209752, longitude: -78.488034)
        annotation.coordinate = coordinates
        annotation.title = "Poli-Gas"
        annotation.subtitle = "Ubicación Actual"
        mapView.addAnnotation(annotation)
        
        centerMapIn(location: CLLocation(latitude: -0.209752, longitude: -78.488034))
        
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
        
        let coordinates = CLLocation(latitude: pinAnnotation.annotation?.coordinate.latitude ?? 0, longitude: pinAnnotation.annotation?.coordinate.longitude ?? 0)
        
        locationPin = coordinates
        saveCurrentLocation(latitud : locationPin.coordinate.latitude, longitud : locationPin.coordinate.longitude)
       
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
        }
    }
    
    func saveCurrentLocation(latitud : Double, longitud : Double){
        
        let useruuid = Auth.auth().currentUser?.uid
        
        // Add a new document in collection "location"
        db.collection("location").document(useruuid!).setData([
            "latitud": latitud,
            "longitud": longitud
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        
    }
    
}
