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
    var locationString: String = ""
    
    @IBAction func postStudentInformation(_ sender: Any) {
    
        ParseClient.createStudentInformation(latitude: self.location!.coordinate.latitude,
                                             longitude: self.location!.coordinate.longitude,
                                             mapString: self.locationString,
                                             linkText: self.linkText,
                                             completion: handlePostResponse(success:error:))
        
    }
    
    func handlePostResponse(success: Bool, error: Error?) {
        if success {
            dismiss(animated: true, completion: nil)
        } else {
            // Present an error to the user if the post fails....
            let alertVC = UIAlertController(title: "Posting Location Failed", message: "Unable to post your current location. Please try again.", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let annotation = MKPointAnnotation()
//        annotation.coordinate = self.location!.coordinate
        annotation.coordinate = self.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        annotation.subtitle = linkText
        
        let latDelta:CLLocationDegrees = 0.05

        let lonDelta:CLLocationDegrees = 0.05

        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)

        let location = CLLocationCoordinate2DMake(annotation.coordinate.latitude, annotation.coordinate.longitude)
        print(location)

        let region = MKCoordinateRegion(center: location, span: span)

        self.mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
        mapView.delegate = self
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
