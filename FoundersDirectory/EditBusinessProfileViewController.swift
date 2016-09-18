//
//  EditBusinessProfileViewController.swift
//  FoundersDirectory
//
//  Created by AJ Bronson on 9/17/16.
//  Copyright © 2016 PrecisionCodes. All rights reserved.
//

import UIKit

class EditBusinessProfileViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        //update the TextView to contain the Business Profile Text, and the background to have rounded edges
        businessProfileTextView.text = PersonController.shared.me.businessProfile
        backgroundView.layer.cornerRadius = 7
    }
    
    //MARK: - Properties
    
    var delegate: BusinessProfileEdited?
    
    //MARK: - Outlets
    
    @IBOutlet weak var businessProfileTextView: UITextView!
    @IBOutlet weak var backgroundView: UIView!
    
    //MARK: - Actions

    //Done - Tell the delegate that the Business Profile TextView Changed, dismiss view
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        delegate?.businessProfileDidChange(newText: businessProfileTextView.text)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - Protocol

/* This protocol will be used to tell the EditViewController about changes made to 
 the Business Profile in the EditBusinessProfileViewController */
protocol BusinessProfileEdited {
    func businessProfileDidChange(newText: String)
}
