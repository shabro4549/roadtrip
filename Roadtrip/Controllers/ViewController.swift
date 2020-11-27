//
//  ViewController.swift
//  Roadtrip
//
//  Created by Shannon Brown on 2020-11-03.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class ViewController: UIViewController, GMSMapViewDelegate {

//
//    var placesClient: GMSPlacesClient!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var daysField: UITextField!
    
    @IBAction func locationFieldTapped(_ sender: UITextField) {
        locationField.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        daysField.text = String(Int(sender.value))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        locationManager.delegate = self
        locationField.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        

        
//        placesClient = GMSPlacesClient.shared()
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
//        self.view.addSubview(mapView)
//
//                // Creates a marker in the center of the map.
//                let marker = GMSMarker()
//                marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//                marker.title = "Brisbane"
//                marker.snippet = "Australia"
//
//                marker.map = mapView
        
//        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
//                                                    UInt(GMSPlaceField.placeID.rawValue))
//        placesClient?.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: fields, callback: {
//          (placeLikelihoodList: Array<GMSPlaceLikelihood>?, error: Error?) in
//          if let error = error {
//            print("An error occurred: \(error.localizedDescription)")
//            return
//          }
//
//          if let placeLikelihoodList = placeLikelihoodList {
//            for likelihood in placeLikelihoodList {
//              let place = likelihood.place
//              print("Current Place name \(String(describing: place.name)) at likelihood \(likelihood.likelihood)")
//              print("Current PlaceID \(String(describing: place.placeID))")
//            }
//          }
//        })
    }
}

//MARK: - CLLocationManager Delegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        print(location.latitude)
        print(location.longitude)
        mapView.animate(toLocation: location)
        mapView.animate(toZoom: 1.0)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

//MARK: - GMSAutocomplete Delegate

extension ViewController: GMSAutocompleteViewControllerDelegate {
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    // Get the place name from 'GMSAutocompleteViewController'
    // Then display the name in textField
    locationField.text = place.name
// Dismiss the GMSAutocompleteViewController when something is selected
    dismiss(animated: true, completion: nil)
  }
func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // Handle the error
    print("Error: ", error.localizedDescription)
  }
func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    // Dismiss when the user canceled the action
    dismiss(animated: true, completion: nil)
  }
}

//MARK: - UITextField Delegate

extension ViewController: UITextFieldDelegate {
    @IBAction func enterPressed(_ sender: UIButton) {
        locationField.endEditing(true)
        print(locationField.text!)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please enter your location"
            return false
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

        if identifier == "resultsSegue" {
            if locationField.text == "" {
                locationField.attributedPlaceholder = NSAttributedString(string: "Please enter your location", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                return false
            }
        }

        return true
    }

}

