//
//  ProfileViewController.swift
//  FoundersDirectory
//
//  Created by AJ Bronson on 9/15/16.
//  Copyright © 2016 PrecisionCodes. All rights reserved.
//

import UIKit
import MessageUI

class ProfileViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    //MARK: - Properties
    
    var person: Person?
    var me = false
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var spouseLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var joinedLabel: UILabel!
    @IBOutlet weak var businessTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    //MARK: - Helper Methods
    
    func updateUI() {
        //Update labels
        guard let person = person else { return }
        
        nameLabel.text = person.firstName + " " + person.lastName
        companyLabel.text = person.companyName
        phoneLabel.text = person.phoneHidden ? "Private" : ((person.phone?.characters.count)! > 0 ? person.phone : "(Unlisted)")
        phoneLabel.textColor = person.phoneHidden ? UIColor.red : ((person.phone?.characters.count)! == 0 ? UIColor(red: 226.0/255, green: 207.0/255, blue: 11.0/255, alpha: 1.0) : UIColor(red: 29.0/255, green: 104.0/255, blue: 9/255, alpha: 1.0))
        emailLabel.text = person.emailHidden ? "Private" : ((person.email?.characters.count)! > 0 ? person.email : "(Unlisted)")
        emailLabel.textColor = person.emailHidden ? UIColor.red : ((person.email?.characters.count)! == 0 ? UIColor(red: 226.0/255, green: 207.0/255, blue: 11.0/255, alpha: 1.0) : UIColor(red: 29.0/255, green: 104.0/255, blue: 9/255, alpha: 1.0))
        statusLabel.text = "Status: \(person.status == nil ? "" : person.status!.rawValue)"
        businessTextView.text = person.businessProfile
        profileImageView.image = person.photo
        //format the date to extract the year
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        joinedLabel.text = "Joined: \(dateFormatter.string(from: person.yearJoined as Date))"
        //customize buttons
        emailButton.layer.cornerRadius = 5
        textButton.layer.cornerRadius = 5
        callButton.layer.cornerRadius = 5
        emailButton.layer.borderWidth = 0.5
        textButton.layer.borderWidth = 0.5
        callButton.layer.borderWidth = 0.5
        
        if let spouse = person.spouseName {
            spouseLabel.text = spouse.characters.count > 0 ? "Spouse: \(spouse)" : "Spouse: (Unlisted)"
        }
        
        if !me {
            editButton.isEnabled = false
            
            //if they have elected to hide their email/phone, disable the buttons accordingly
            if person.emailHidden || (person.email?.characters.count)! < 1 {
                emailButton.isEnabled = false
                emailButton.backgroundColor = UIColor.lightGray
            }
            
            if person.phoneHidden || (person.phone?.characters.count)! < 1 {
                textButton.isEnabled = false
                callButton.isEnabled = false
                textButton.backgroundColor = UIColor.lightGray
                callButton.backgroundColor = UIColor.lightGray
            }
            
        } else {
            //In this case, the profile view is the logged in user. Disable these buttons
            textButton.isEnabled = false
            callButton.isEnabled = false
            emailButton.isEnabled = false
            textButton.backgroundColor = UIColor.lightGray
            callButton.backgroundColor = UIColor.lightGray
            emailButton.backgroundColor = UIColor.lightGray
        }
    }
    
    func updateWith(person: Person, me: Bool) {
        self.person = person
        self.me = me
    }
    
    //MARK: - Actions
    
    @IBAction func callButtonTapped(_ sender: UIButton) {
        //Perform Phone call
        if let person = person, let phone = person.phone, let url = URL(string: "tel://\(phone)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func textButtonTapped(_ sender: UIButton) {
        //Open Text Message
        guard let person = person, let phone = person.phone else { return }
        let messageVC = MFMessageComposeViewController()
        messageVC.recipients = ["\(phone)"]
        messageVC.messageComposeDelegate = self;
        self.present(messageVC, animated: false, completion: nil)
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        //Open Email
        guard let person = person, let email = person.email else { return }
        let controller = MFMailComposeViewController()
        controller.mailComposeDelegate = self
        controller.setToRecipients([email])
        self.present(controller, animated: true, completion: nil)
    }
    
    //MARK: - Delegate Methods
    
    //SMS delegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Email delegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
