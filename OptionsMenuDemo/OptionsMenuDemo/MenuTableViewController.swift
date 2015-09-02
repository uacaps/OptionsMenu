//
//  MenuTableViewController.swift
//  OptionsMenuDemo
//
//  Created by Niklas Fahl on 9/2/15.
//  Copyright © 2015 CAPS. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Options Menu Demo"
        self.tableView.registerNib(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MenuTableViewCell = tableView.dequeueReusableCellWithIdentifier("MenuTableViewCell", forIndexPath: indexPath) as! MenuTableViewCell
        cell.menuTitleLabel.text = "Small Menu"

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let smallOptionsMenuVC: SmallOptionsMenuViewController = SmallOptionsMenuViewController(nibName: "SmallOptionsMenuViewController", bundle: nil)
        self.navigationController?.pushViewController(smallOptionsMenuVC, animated: true)
    }
    
}
