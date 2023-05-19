//
//  MapViewController.swift
//  TravelHelper
//
//  Created by Qin Geng on 5/9/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController : UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager?
    var previousLocation: CLLocation?
    
    override func viewDidLoad() {
        
        view.backgroundColor = .gray
        super.viewDidLoad()
        
        // Defines the bottom border of the search text field
        // self.searchTextField.setBottomBorder()

        // Sets the location manager singleton instance
        if locationManager == nil {
            locationManager = CLLocationManager()
        }

        //
        locationManager!.delegate = self
        locationManager!.requestAlwaysAuthorization()
        locationManager!.requestLocation()
    }
    
    
    @IBAction func onSearchButtonPress(_ sender: Any) {
        searchTextField.resignFirstResponder()
        if searchTextField.text!.count == 0 {
            let alert = UIAlertController(title: "No search query", message: "Please, type some location to search it on the map", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                self.searchTextField.becomeFirstResponder()
            }))
            present(alert, animated: true, completion: nil)
        }
        searchLocationForText(searchTextField.text!)
    }
    
    
    @IBAction func onCurrentLocationButtonPress(_ sender: Any) {
        print ("onCurrentLocationButtonPress")
        if previousLocation == nil {
            print("nil")
            locationManager!.requestLocation()
            return
        }
        centerOnRegion(nil)
        clearSearch()
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func searchLocationForText(_ string: String) {
        clearSearch()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = string

        MKLocalSearch(request: request).start { (response, error) in
            guard let response = response else { return }
            if response.mapItems.count == 0 { return  }

            let relevantItem = response.mapItems[0]

            self.centerOnRegion(relevantItem.placemark.coordinate)
        }
    }
    
    func centerOnRegion(_ region: CLLocationCoordinate2D?) {
        let diameter = 500
        if region == nil {
            let region: MKCoordinateRegion = MKCoordinateRegion(center: previousLocation!.coordinate, latitudinalMeters: CLLocationDistance(diameter), longitudinalMeters: CLLocationDistance(diameter))
            mapView.setRegion(region, animated: true)
        } else {
            let region: MKCoordinateRegion = MKCoordinateRegion(center: region!, latitudinalMeters: CLLocationDistance(diameter), longitudinalMeters: CLLocationDistance(diameter))
            mapView.setRegion(region, animated: true)
        }
    }
    
    func showSearchError() {
        clearSearch()
        let alert = UIAlertController(title: "No results found", message: "We haven't found any result. Please, try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            self.searchTextField.becomeFirstResponder()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func clearSearch() {
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count == 0 { return }
        
        
        let location = locations.first!
        previousLocation = location
        centerOnRegion(nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager did failed with error: \(error.localizedDescription)")
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //searchButtonPressed()
        return true
    }
}

