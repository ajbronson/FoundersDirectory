//
//  FoundersTableViewController.swift
//  FoundersDirectory
//
//  Created by AJ Bronson on 9/15/16.
//  Copyright © 2016 PrecisionCodes. All rights reserved.
//

import UIKit

class FoundersTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: - Data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //The rows contained in each section. The first section will always have one - the logged in user
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return PersonController.shared.people.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FounderCell") as? FoundersCellViewController else { return UITableViewCell() }
        
        //set the cell's contents. The logged in user, if it's section 1, else all other users.
        if indexPath.section == 0 {
            cell.updateWith(person: PersonController.shared.me)
        } else {
            cell.updateWith(person: PersonController.shared.people[indexPath.row])
        }

        return cell
    }
    
    //Title for the two sections
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Me"
        case 1:
            return "Founders"
        default:
            return ""
        }
    }
    
    //MARK: Segue Method
    
    //When user clicks cell, segue to Profile View, passing the person object that was selected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfile" {
            if let profileVC = segue.destination as? ProfileViewController, let index = tableView.indexPathForSelectedRow {
                profileVC.updateWith(person: index.section == 0 ? PersonController.shared.me : PersonController.shared.people[index.row], me: index.section == 0 ? true : false)
            }
        }
    }
    
}
