//
//  BusinessesViewController.swift
//  yelp_client
//
//  Created by Jayme Woogerd on 4/22/15.
//  Copyright (c) 2015 Jayme Woogerd. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var businessesTableView: UITableView!
    var businesses: [Business]!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.businessesTableView.reloadData()
        })
        
        businessesTableView.dataSource = self
        businessesTableView.delegate = self
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
        let business = businesses![indexPath.row]

        cell.nameLabel.text = business.name
        cell.addressLabel.text = business.address
        cell.categoriesLabel.text = business.categories
        cell.posterImageView.setImageWithURL(business.imageURL)
        cell.ratingImageView.setImageWithURL(business.ratingImageURL)
        return cell
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
