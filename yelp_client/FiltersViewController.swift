//
//  FiltersViewController.swift
//  yelp_client
//
//  Created by Jayme Woogerd on 4/26/15.
//  Copyright (c) 2015 Jayme Woogerd. All rights reserved.
//

import UIKit

enum Sections: Int {
    case  Sort = 0, Radius, Deals, Categories
}

@objc protocol FiltersViewControllerDelegate: class {
    optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String: AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SortCellDelegate, SwitchCellDelegate {

    @IBOutlet weak var filtersTableView: UITableView!
    
    var categories: [[String: String]]!
    var switchStates = [Int: Bool]()
    var hasDeal = false
    var sortModeIndex = 0
    var radiusIndex = 0
    let filterSections = ["Sort", "Radius", "Deals", "Categories"]
    weak var delegate: FiltersViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        categories = yelpCategories()
        
        filtersTableView.delegate = self
        filtersTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = filtersTableView.indexPathForCell(switchCell)!
        if indexPath.section == Sections.Categories.rawValue {
            switchStates[indexPath.row] = value
        } else if indexPath.section == Sections.Deals.rawValue {
            hasDeal = value
        }
    }
   
    func sortCell(sortCell: SortCell, indexSelected index: Int) {
        let indexPath = filtersTableView.indexPathForCell(sortCell)!
        if indexPath.section == Sections.Sort.rawValue {
            self.sortModeIndex = index
        } else if indexPath.section == Sections.Radius.rawValue {
            self.radiusIndex = index
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filterSections.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return filterSections[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.Categories.rawValue:
            return categories.count
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.Sort.rawValue, Sections.Radius.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier("SortCell", forIndexPath: indexPath) as! SortCell
            cell.delegate = self
            if indexPath.section == Sections.Sort.rawValue {
                cell.setLabels(["Best Match", "Distance", "Rating"])
            } else {
                cell.setLabels(["1 mile", "2 miles", "5 miles"])
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
            cell.delegate = self
            if indexPath.section == Sections.Categories.rawValue {
                cell.switchLabel.text = categories[indexPath.row]["name"]
                cell.onSwitch.on = switchStates[indexPath.row] ?? false
            } else {
                cell.switchLabel.text = "Offering a Deal"
                cell.onSwitch.on = self.hasDeal ?? false
            }
            return cell
        }
    }
    
    @IBAction func onSearch(sender: AnyObject) {
        var filters = [String: AnyObject]()
        var selectedCategories = [String]()

        for (row, selected) in switchStates {
            if selected {
                selectedCategories.append(self.categories[row]["code"]!)
            }
        }
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories
        }
        filters["deal"] = self.hasDeal
        filters["sort"] = self.sortModeIndex
        filters["radius"] = self.radiusIndex
       
        delegate?.filtersViewController?(self, didUpdateFilters: filters)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func yelpCategories() -> [[String: String]] {
        return [["name" : "Beer Garden", "code": "beergarden"],
            ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
            ["name" : "Bulgarian", "code": "bulgarian"],
            ["name" : "Hawaiian", "code": "hawaiian"],
            ["name" : "Japanese", "code": "japanese"],
            ["name" : "Vegan", "code": "vegan"]]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
