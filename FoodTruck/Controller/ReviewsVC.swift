//
//  ReviewsVC.swift
//  FoodTruck
//
//  Created by Javier Gomez on 1/7/19.
//  Copyright © 2019 Javier Gomez. All rights reserved.
//

import UIKit

class ReviewsVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedFoodTruck: FoodTruck?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = selectedFoodTruck!.name
        
        tableView.dataSource = self
        tableView.delegate = self
        
        DataService.instance.delegate = self
        
        if let truck = selectedFoodTruck {
            nameLabel.text = truck.name
            DataService.instance.getAllReviews(for: truck)
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140.0
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}

extension ReviewsVC: DataServiceDelegate {
    func trucksLoaded() {}
    
    func reviewsLoaded() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
}

extension ReviewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataService.instance.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as? ReviewCell {
            cell.configureCell(review: DataService.instance.reviews[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}
