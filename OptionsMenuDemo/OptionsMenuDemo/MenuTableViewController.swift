//
//  MenuTableViewController.swift
//  OptionsMenuDemo
//
//  Created by Niklas Fahl on 9/2/15.
//  Copyright © 2015 CAPS. All rights reserved.
//

import UIKit
import Foundation


class MenuTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Options Menu Demo"
        self.tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath as IndexPath) as! MenuTableViewCell
        cell.menuTitleLabel.text = "Small Menu"
        
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let smallOptionsMenuVC: SmallOptionsMenuViewController = SmallOptionsMenuViewController(nibName: "SmallOptionsMenuViewController", bundle: nil)
        self.navigationController?.pushViewController(smallOptionsMenuVC, animated: true)
    }
    
    
    
}
