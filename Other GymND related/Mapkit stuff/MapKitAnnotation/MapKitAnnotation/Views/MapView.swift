//
//  MapView.swift
//  MapKitAnnotation
//
//  Created by Tee Becker on 11/17/20.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    /// instead of using mapViewDidChangeVisibleRegion, we pass the data to MapView and use @Binding to store this value somewhere else:
    /// The Coordinator receive value from Mapkit, and pass to MapView,
    /// Then MapView put the value in @Binding property and store it
    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    ///(1)
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapview = MKMapView()
        mapview.delegate = context.coordinator ///(2)
        addAnnotationAndCenter(for: mapview) ///(3)
        return mapview
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
    }
    
    ///(2)
    /// sends back a configured instance of Coordinator. It will send itself ti the coordinator and report what is happening.
    func makeCoordinator() -> Coordinator{
        Coordinator(self)
    }

    ///(3)
    func addAnnotationAndCenter(for mapview: MKMapView){
        ///This class conforms to MKAnnotation protocol, which display annotations
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Capital of Belgium"
        
        let coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
        annotation.coordinate = coordinate
        mapview.addAnnotation(annotation)
        
        // center map to where annotation is
        let regionInMeters:Double = 10000
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapview.setRegion(region, animated: true)
    }
    
    
    
}
    
