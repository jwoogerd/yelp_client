//
//  BusinessCell.swift
//  yelp_client
//
//  Created by Jayme Woogerd on 4/22/15.
//  Copyright (c) 2015 Jayme Woogerd. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingsImageView: UIImageView!

    var business: Business! {
        didSet {
        nameLabel.text = business.name
        addressLabel.text = business.address
        categoriesLabel.text = business.categories
        reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
        distanceLabel.text = business.distance
        posterImageView.setImageWithURL(business.imageURL)
        ratingsImageView.setImageWithURL(business.ratingImageURL)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.layer.cornerRadius = 3
        posterImageView.clipsToBounds = true
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.width
        addressLabel.preferredMaxLayoutWidth = nameLabel.frame.width
        categoriesLabel.preferredMaxLayoutWidth = nameLabel.frame.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
