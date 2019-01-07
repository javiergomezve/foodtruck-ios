//
//  AddReviewVC.swift
//  FoodTruck
//
//  Created by Javier Gomez on 1/7/19.
//  Copyright © 2019 Javier Gomez. All rights reserved.
//

import UIKit

class AddReviewVC: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reviewTextField: UITextView!
    
    var selectedFoodTruck: FoodTruck?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let truck = selectedFoodTruck {
            headerLabel.text = truck.name
        } else {
            headerLabel.text = "Error"
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let truck = selectedFoodTruck else {
            showAlert(title: "Error", message: "Could not get selected truck")
            return
        }
        
        guard let title = titleTextField.text, titleTextField.text != "" else {
            showAlert(title: "Error", message: "Please, enter a title")
            return
        }
        
        guard let text = reviewTextField.text, reviewTextField.text != "" else {
            showAlert(title: "Error", message: "Please, enter a text")
            return
        }
        
        DataService.instance.addNewReview(truck.id, title: title, text: text, completion: { (Success) in
            if Success {
                print("addNewReview: success")
                DataService.instance.getAllReviews(for: truck)
                self.dismissVC()
            } else {
                print("addNewReview: error")
                self.showAlert(title: "Error", message: "An error occurred saving the new review")
            }
        })
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismissVC()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
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
