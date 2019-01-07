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
    
    let SHOW_REVIEWS_VC = "showReviewsVC"
    let ADD_REVIEWS_VC = "addReviewsVC"

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
    
    @IBAction func reviewsButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: SHOW_REVIEWS_VC, sender: self)
    }
    
    @IBAction func addReviewButtonTapped(_ sender: Any) {
        if AuthService.instance.isAuthenticated == true {
            performSegue(withIdentifier: ADD_REVIEWS_VC, sender: self)
        } else {
            showLoginVC()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SHOW_REVIEWS_VC {
            let destinationVC = segue.destination as? ReviewsVC
            destinationVC?.selectedFoodTruck = selectedFoodTruck
        } else if segue.identifier == ADD_REVIEWS_VC {
            let destinationVC = segue.destination as? AddReviewVC
            destinationVC?.selectedFoodTruck = selectedFoodTruck
        }
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinatesRegion = MKCoordinateRegion(center: selectedFoodTruck!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinatesRegion, animated: true)
    }
    
    func showLoginVC() {
        logInVC = LogInVC()
        logInVC?.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(logInVC!, animated: true, completion: nil)
    }
}
