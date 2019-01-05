//
//  MainVC.swift
//  FoodTruck
//
//  Created by Javier Gomez on 1/5/19.
//  Copyright © 2019 Javier Gomez. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.instance.delegate = self

        DataService.instance.getAllFoodTrucks()
    }
}

extension MainVC: DataServiceDelegate {
    func trucksLoaded() {
        print(DataService.instance.foodTrucks)
    }
    
    func reviewsLoaded() {
        
    }
}
