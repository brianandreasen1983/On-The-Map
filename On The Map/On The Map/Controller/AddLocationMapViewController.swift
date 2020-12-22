//
//  AddLocationMapViewController.swift
//  On The Map
//
//  Created by Brian Andreasen on 10/11/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var location: CLLocation?
    var linkText: String = ""
    
    @IBAction func postStudentInformation(_ sender: Any) {
//        ParseClient.createStudentInformation(self.location?.coordinate.latitude, self.location?.coordinate.longitude, self.linkText)
        
//        ParseClient.createStudentInformation(latitude: 45.237369, longitude: -93.653923, linkText: "https://www.apple.com", completion: testHandleResponse(success:error:))
        
        ParseClient.createStudentInformation(latitude: self.location!.coordinate.latitude, longitude: self.location!.coordinate.longitude, linkText: self.linkText, completion: testHandleResponse(success:error:))
        
    }
    
    func testHandleResponse(success: Bool, error: Error?) {
        if success {
            print("yaya")
        } else {
            print("no no")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.location!.coordinate
        annotation.subtitle = linkText
        
        let latDelta:CLLocationDegrees = 0.05

        let lonDelta:CLLocationDegrees = 0.05

        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)

        let location = CLLocationCoordinate2DMake(annotation.coordinate.latitude, annotation.coordinate.longitude)
        print(location)

        let region = MKCoordinateRegion(center: location, span: span)

        self.mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let url = view.annotation?.subtitle! {
                app.open(URL(string: url)!)
            }
        }
    }
}
