//
//  DetailsFoodTruckVC.swift
//  FoodTruck
//
//  Created by Javier Gomez on 1/6/19.
//  Copyright © 2019 Javier Gomez. All rights reserved.
//

import UIKit
import MapKit

class DetailsFoodTruckVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var avgCostLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var selectedFoodTruck: FoodTruck?
    var logInVC: LogInVC?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = selectedFoodTruck!.name
        foodTypeLabel.text = selectedFoodTruck!.foodType
        avgCostLabel.text = "$\(String(describing: selectedFoodTruck!.avgCost))"
        mapView.addAnnotation(selectedFoodTruck!)
        centerMapOnLocation(CLLocation(latitude: selectedFoodTruck!.lat, longitude: selectedFoodTruck!.long))
        
    }
    
    @IBAction func backButtonTapped(sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinatesRegion = MKCoordinateRegion(center: selectedFoodTruck!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinatesRegion, animated: true)
    }
}
