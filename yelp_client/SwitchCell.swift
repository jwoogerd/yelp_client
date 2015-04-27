//
//  SwitchCell.swift
//  yelp_client
//
//  Created by Jayme Woogerd on 4/26/15.
//  Copyright (c) 2015 Jayme Woogerd. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate: class {
    optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var onSwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    
    weak var delegate: SwitchCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onSwitchToggled(sender: AnyObject) {
        delegate?.switchCell?(self, didChangeValue: onSwitch.on)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
