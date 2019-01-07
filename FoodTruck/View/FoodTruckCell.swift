//
//  FoodTruckCell.swift
//  FoodTruck
//
//  Created by Javier Gomez on 1/6/19.
//  Copyright © 2019 Javier Gomez. All rights reserved.
//

import UIKit

class FoodTruckCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var avgCost: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(truck: FoodTruck) {
        nameLabel.text = truck.name
        foodTypeLabel.text = truck.foodType
        avgCost.text = "$\(truck.avgCost)"
    }
}
