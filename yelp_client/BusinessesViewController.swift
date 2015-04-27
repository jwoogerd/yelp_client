//
//  BusinessesViewController.swift
//  yelp_client
//
//  Created by Jayme Woogerd on 4/22/15.
//  Copyright (c) 2015 Jayme Woogerd. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate {
    
    @IBOutlet weak var businessesTableView: UITableView!

    var businesses: [Business]!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Business.searchWithTerm("Restaurants", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.businessesTableView.reloadData()
        })
        
        businessesTableView.dataSource = self
        businessesTableView.delegate = self
        // self.navigationItem.titleView = searchBar
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
        var categories = filters["categories"] as? [String]
        Business.searchWithTerm("Restaurants", sort: nil, categories: categories, deals: nil)
            {(businesses: [Business]!, error: NSError!) -> Void in
                self.businesses = businesses
                self.businessesTableView.reloadData()
            }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
    }

}
