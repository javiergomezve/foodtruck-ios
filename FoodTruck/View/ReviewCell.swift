//
//  ReviewCell.swift
//  FoodTruck
//
//  Created by Javier Gomez on 1/7/19.
//  Copyright © 2019 Javier Gomez. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(review: FoodTruckReview) {
        titleLabel.text = review.title
        reviewTextLabel.text = review.text
    }
}
