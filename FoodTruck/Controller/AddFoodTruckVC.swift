//
//  AddFoodTruckVC.swift
//  FoodTruck
//
//  Created by Javier Gomez on 1/6/19.
//  Copyright © 2019 Javier Gomez. All rights reserved.
//

import UIKit

class AddFoodTruckVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var foodTypeTextField: UITextField!
    @IBOutlet weak var avgCostTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, nameTextField.text != "" else {
            showAlert(title: "Error", message: "Please, enter a name")
            return
        }
        
        guard let foodType = foodTypeTextField.text, foodTypeTextField.text != "" else {
            showAlert(title: "Error", message: "Please, enter a food type")
            return
        }
        
        guard let avgCost = Double(avgCostTextField.text!), avgCostTextField.text != "" else {
            showAlert(title: "Error", message: "Please, enter a average cost")
            return
        }
        
        guard let lat = Double(latitudeTextField.text!), latitudeTextField.text != "" else {
            showAlert(title: "Error", message: "Please, enter a latitude")
            return
        }
        
        guard let long = Double(longitudeTextField.text!), longitudeTextField.text != "" else {
            showAlert(title: "Error", message: "Please, enter a longitude")
            return
        }
        
        DataService.instance.addNewFoodTruck(name, foodType: foodType, avgcost: avgCost, latitude: lat, longitude: long) { (Success) in
            if Success {
                print("addNewFoodTruck: success")
                self.dismissVC()
            } else {
                print("addNewFoodTruck: error")
                self.showAlert(title: "Error", message: "An error occurred saving the new food truck")
            }
        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismissVC()
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        dismissVC()
    }

    func dismissVC() {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(title: String?, message: String?) -> Void {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
