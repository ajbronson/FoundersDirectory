//
//  FoundersCellViewController.swift
//  FoundersDirectory
//
//  Created by AJ Bronson on 9/18/16.
//  Copyright © 2016 PrecisionCodes. All rights reserved.
//

import UIKit

class FoundersCellViewController: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    //MARK: - Helper Method
    
    //update the two labels and image from the passed person object
    func updateWith(person: Person) {
        nameLabel.text = "\(person.firstName) \(person.lastName)"
        companyLabel.text = person.companyName
        profileImageView.image = person.photo
    }
    
}
