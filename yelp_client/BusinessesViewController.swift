//
//  BusinessesViewController.swift
//  yelp_client
//
//  Created by Jayme Woogerd on 4/22/15.
//  Copyright (c) 2015 Jayme Woogerd. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var businessesTableView: UITableView!

    var businesses: [Business]!
    let searchBar = UISearchBar()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Business.searchWithTerm("Restaurants", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.businessesTableView.reloadData()
        })
        
        self.navigationItem.titleView = searchBar
        searchBar.placeholder = "e.g. Thai, Coffee"
        searchBar.delegate = self
        businessesTableView.dataSource = self
        businessesTableView.delegate = self
        businessesTableView.rowHeight = UITableViewAutomaticDimension
        businessesTableView.estimatedRowHeight = 120
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = self.businesses {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        cell.business = businesses![indexPath.row]
        return cell
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        let categories = filters["categories"] as? [String]
        let hasDeal = filters["deal"] as? Bool
        let sortMode = YelpSortMode(rawValue: filters["sort"] as! Int)
        let METERS_PER_MILE = 1609
        var radii = [1, 2, 5]  // miles
        let radius = radii[filters["radius"] as! Int] * METERS_PER_MILE
        
        Business.searchWithTerm("Restaurants", sort: sortMode, categories: categories, deals: hasDeal, radius: radius)
            {(businesses: [Business]!, error: NSError!) -> Void in
                self.businesses = businesses
                self.businessesTableView.reloadData()
            }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        Business.searchWithTerm(searchBar.text as String!) {(businesses: [Business]!, error: NSError!) ->
            Void in
                self.businesses = businesses
                self.businessesTableView.reloadData()
        }
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
    }

}
