//
//  SortCell.swift
//  yelp_client
//
//  Created by Jayme Woogerd on 4/27/15.
//  Copyright (c) 2015 Jayme Woogerd. All rights reserved.
//

import UIKit

protocol SortCellDelegate: class {
    func sortCell(sortCell: SortCell, indexSelected index: Int)
}

class SortCell: UITableViewCell {

    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    weak var delegate: SortCellDelegate?

    @IBAction func onValueChanged(sender: AnyObject) {
        delegate?.sortCell(self, indexSelected: sortSegmentedControl.selectedSegmentIndex)
    }
    
    func setLabels(labels: [String]) {
        for (index, label) in enumerate(labels) {
            sortSegmentedControl.setTitle(label, forSegmentAtIndex: index)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
