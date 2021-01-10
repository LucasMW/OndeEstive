//
//  ViewController.swift
//  OndeEstive
//
//  Created by Lucas Menezes on 1/1/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import NVActivityIndicatorView

class ViewController: UIViewController,NVActivityIndicatorViewable, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        print("Collected from \(UIDevice().name)")
        print("Is it \(UIDevice.current.name)?")
        print("Or is it \(NSUserName())?")
        print("Or even \(NSFullUserName())?")
        print("I will go with \(parseDeviceName(deviceName: UIDevice().name))")
        let device = UIDevice().identifierForVendor?.uuidString ?? "Unknown"
        print(device)
        print(device.hash)
        // Do any additional setup after loading the view.
    }
    @IBAction func loadEverything(_ sender: Any) {
        self.startAnimating(nil, message: "Carregando", messageFont:  nil, type: .circleStrokeSpin, color: .none, padding: .none, displayTimeThreshold: .none, minimumDisplayTime: .none, backgroundColor: .none, textColor: .none, fadeInAnimation: .none)
        DispatchQueue.init(label: "xxx").async {
            self.loadAll()
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        print("BAD SIGN")
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func addAnnotations(coords: [CLLocation]){
        for coord in coords{
            let CLLCoordType = CLLocationCoordinate2D(
                latitude: coord.coordinate.latitude,
                longitude: coord.coordinate.longitude);
            CLGeocoder().reverseGeocodeLocation(coord) { (placemarks, error) in
                print(placemarks)
                print(error)
            }
            let anno = MKPointAnnotation();
            anno.title = "\(coord.coordinate)"
            anno.coordinate = CLLCoordType;
            mapView.addAnnotation(anno);
        }
        
    }
    func loadAll() {
//        let photos = fetchPhotoFromLibrary()
//        let locations = photos.map({$0.location!})
        let locations = fetchLocationsFromLibrary()
        let str = locations.map({"\($0)"})
        print(str.description)
        print("bytes: \(str.description.count)")
        addAnnotations(coords: locations)
        DispatchQueue.main.async {
            self.stopAnimating()
            guard let firstLocation = locations.first else {
                return
            }
            self.mapView.camera.centerCoordinate = firstLocation.coordinate
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil;
        }else{
            let pinIdent = "Pin";
            var pinView: MKPinAnnotationView;
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdent) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation;
                pinView = dequeuedView;
            }else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
                
            }
            return pinView;
        }
    }
    
}

