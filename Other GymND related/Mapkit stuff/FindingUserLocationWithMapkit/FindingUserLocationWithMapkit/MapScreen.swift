//
//  MapScreen.swift
//  FindingUserLocationWithMapkit
//
//  Created by Tee Becker on 11/2/20.
//

import UIKit
import MapKit
import CoreLocation

class MapScreen: UIViewController{
    
    let mapkitView = MKMapView()
    let locationManager = CLLocationManager()
    let regionInMeters:Double = 100 // higher the number, the more zoomed out map is based on center location
//    let imageView = UIImageView()
    let label = UILabel()
    var previousLocation: CLLocation?
    var annotation: MKAnnotation?
    var previousAnnotaion: MKAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Map Stuff"
        view.backgroundColor = .white
        
        configure() // add subviews
        configureMapView() // configure mapview and TAMIC
        checkLocationServices() // set up locationmanager deligate, request authorization, check authorization for the different cases
//        configurePin() // create the pin
        configureLabel() // create the label
    }
    
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            // services enabled and we are good, set up locationManager
            setUpLocationManager()
            checkLocationAuthorization()
        } else {
            // its not enabled. show alert to tell user to turn this on
        }
    }
    
    
    func setUpLocationManager(){
        locationManager.delegate = self  // setting vc to be the delegate of LM
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func checkLocationAuthorization(){
        switch CLAuthorizationStatus.authorizedWhenInUse {
        
        case .authorizedAlways:
            break
            
        case .authorizedWhenInUse:
            // do map stuff
            mapkitView.showsUserLocation = true
            centerViewOnUserLocation() // center view on location and only show 10000 meters of surrounding from center
            locationManager.startUpdatingLocation()
            previousLocation = getCenterLocation(for: mapkitView)
            break
            
        case.denied:
            // show alert instructing them to turn on permission
            break
            
        case .restricted:
            // show alert to give feedback as its restricted
            break
            
        default:
            // request permission,
            locationManager.requestWhenInUseAuthorization()
            break
        }
    }
    
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapkitView.setRegion(region, animated: true)
        }
    }
    
    
    func getCenterLocation(for mapview: MKMapView) -> CLLocation{
        let latitude = mapview.centerCoordinate.latitude
        let longitude = mapview.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func addAnnotation(for center: CLLocation) {
        let annotationForCenter = location(
            title: "center",
            coordinate: center.coordinate,
            info: "potentially the address")
        
        mapkitView.addAnnotation(annotationForCenter)
        previousAnnotaion = annotationForCenter
    }
    
    // MARK: configuring
    
    func configure(){
        view.addSubview(mapkitView)
//        view.addSubview(imageView)
        view.addSubview(label)
    }
    
    func configureMapView(){
        mapkitView.delegate = self // setting the VC to be the delegate of the map
        
        mapkitView.translatesAutoresizingMaskIntoConstraints = false
        mapkitView.mapType = MKMapType.standard
        mapkitView.isZoomEnabled = true
        mapkitView.isScrollEnabled = true
        
        NSLayoutConstraint.activate([
            mapkitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapkitView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45),
            mapkitView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapkitView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
//    func configurePin(){
//        imageView.image = UIImage(named: "redPin")
//        imageView.contentMode = .scaleAspectFit
//
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            imageView.heightAnchor.constraint(equalToConstant: 40),
//            imageView.widthAnchor.constraint(equalToConstant: 40),
//            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//    }
    
    func configureLabel(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = UIFont(name: "SF Pro", size: 44)
        label.text = "Label Text"
        label.textAlignment = .center
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: mapkitView.bottomAnchor),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    
}

// MARK: extensions

extension MapScreen: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

extension MapScreen: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        
        // add annotation for center
        addAnnotation(for: center)
        
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else{return}
        // distance is greater than a certain length ( 50 meters )
        guard center.distance(from: previousLocation) > 50 else {return}
        self.previousLocation = center
        
        if let previousAnnotationToRemove = self.previousAnnotaion{
            mapkitView.removeAnnotation(previousAnnotationToRemove)
        }
        
        geoCoder.reverseGeocodeLocation(center) {[weak self] (placemark, error) in
            guard let self = self else {return}
            
            if let error = error {
                print(error.localizedDescription)
                //show alert
            }
            
            guard let placemark = placemark?.first else {
                // show alert
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            let city = placemark.locality ?? ""
            let locationOfPin = "\(streetNumber) \(streetName), \(city)"
            
            //             already found long and lat using getCenterLocation() , below is unnecessary and reptitive
//            guard let latitude: Double = placemark.location?.coordinate.latitude else{return}
//            guard let longitude: Double = placemark.location?.coordinate.longitude else{return}
            
            DispatchQueue.main.async {
                self.label.text = "\(locationOfPin)"
            }
            
            
            
        }
    }
}



