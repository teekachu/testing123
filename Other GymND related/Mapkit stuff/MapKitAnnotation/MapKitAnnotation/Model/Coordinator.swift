//
//  Coordinator.swift
//  MapKitAnnotation
//
//  Created by Tee Becker on 11/17/20.
//

import SwiftUI
import MapKit

///(2)
/// This is needed to act as the delegate for MapView,
/// passing data to and from SwiftUI.
class Coordinator: NSObject, MKMapViewDelegate{
    var parent: MapView
    
    init(_ parent: MapView){
        self.parent = parent
    }
    
    /// will be called whenever the mapview changes its visible region, i.e: when it zooms, rotates, moves etc.
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        print(mapView.centerCoordinate)
    }
    
    /// (4)
    /// create a custom annotation view
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
//        view.canShowCallout = true /// Indicating whether the annotation view is able to display extra information in a callout bubble.
//        return view
//    }
    
}
