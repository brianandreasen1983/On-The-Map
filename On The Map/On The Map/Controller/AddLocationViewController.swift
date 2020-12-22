//
//  AddLocationViewController.swift
//  On The Map
//
//  Created by Brian Andreasen on 4/25/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {
    let mapView = MKMapView()
    var location: CLLocation?
    var geocoder = CLGeocoder()

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!

    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK -- If the forward geo code succeeds then show the next view controller otherwise don't switch
    @IBAction func findLocation(_ sender: Any) {
        activityIndicator.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLocationError(message: String) {
        let alertVC = UIAlertController(title: "Location not found", message: message, preferredStyle: .alert )
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func processGeocodedResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if error != nil {
            showLocationError(message: "Location can't be found. Please try a new location.")
        } else {
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location!
            }
            
            if let location = location {
                let coordinate = location.coordinate
            } else {
                showLocationError(message: "Location can't be matched. Please try again.")
            }
        }

        activityIndicator.stopAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(locationTextField.text ?? "") { (placemarks, error) in
            if (self.locationTextField.text == "") {
                self.showLocationError(message: "A location is required.")
            } else {
                self.processGeocodedResponse(withPlacemarks: placemarks, error: error)
                
                let vc = segue.destination as! AddLocationMapViewController

                if self.location != nil {
                    vc.location = self.location ?? nil
                    vc.linkText = self.linkTextField.text ?? ""
                }
            }
        }
    }
}
