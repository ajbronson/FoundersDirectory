//
//  Person.swift
//  FoundersDirectory
//
//  Created by AJ Bronson on 9/15/16.
//  Copyright © 2016 PrecisionCodes. All rights reserved.
//

import Foundation
import UIKit

class Person {
    
    //MARK: - Properties
    
    var firstName: String
    var lastName: String
    var photo: UIImage
    var companyName: String
    var phone: String?
    var email: String?
    var spouseName: String?
    var businessProfile: String
    var status: Status?
    let yearJoined: NSDate
    var emailHidden: Bool
    var phoneHidden: Bool
    
    //MARK: - Initializer
    
    init(firstName: String, lastName: String, photo: String, companyName: String, phone: String?, email: String?, spouseName: String?,  status: Status?, businessProfile: String, yearJoined: NSDate = NSDate(), emailHidden: Bool = false, phoneHidden: Bool = false) {
        self.firstName = firstName
        self.lastName = lastName
        self.photo = UIImage(named: photo)!
        self.phone = phone
        self.companyName = companyName
        self.email = email
        self.spouseName = spouseName
        self.status = status
        self.yearJoined = yearJoined
        self.businessProfile = businessProfile
        self.emailHidden = emailHidden
        self.phoneHidden = phoneHidden
    }
    
}

//MARK: - Status Enum

enum Status: String {
    case gold = "Gold"
    case silver = "Silver"
    case bronze = "Bronze"
}
