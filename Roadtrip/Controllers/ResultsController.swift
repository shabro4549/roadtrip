//
//  ResultsController.swift
//  Roadtrip
//
//  Created by Shannon Brown on 2020-11-25.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class ResultsController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    let cityNames = ["Santa Cruz", "Lake Tahoe", "Big Sur", "Yosemite", "Carmel"]
    let durations = ["1hr 13min", "2hr 27min", "3hr 27min", "3hr 6min", "3hr 55min"]
    let imageNames = ["santacruz", "laketahoe", "bigsur", "yosemite", "carmel"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        let nib = UINib(nibName: "ResultsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ResultsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
}

//MARK: - CLLocationManager Delegate

extension ResultsController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

         let locValue:CLLocationCoordinate2D = manager.location!.coordinate
         mapView.animate(toLocation: CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude))

         mapView.setMinZoom(4.6, maxZoom: 20)

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - UITableView Delegate

extension ResultsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        cell.resultsCityLabel.text = cityNames[indexPath.row]
        cell.resultsDurationLabel.text = durations[indexPath.row]
        cell.imageView?.image = UIImage(named: imageNames[indexPath.row])
        return cell
        
    }
    
    
    
}

