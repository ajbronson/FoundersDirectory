//
//  EditViewController.swift
//  FoundersDirectory
//
//  Created by AJ Bronson on 9/15/16.
//  Copyright © 2016 PrecisionCodes. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, BusinessProfileEdited, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.me = PersonController.shared.me
        updateUI()
        setupTextFields()
    }
    
    //MARK: - Properties
    
    var me: Person?
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var spouseTextField: UITextField!
    @IBOutlet weak var businessTextView: UITextView!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var emailShownLabel: UILabel!
    @IBOutlet weak var phoneShownLabel: UILabel!
    @IBOutlet weak var emailSwitch: UISwitch!
    @IBOutlet weak var phoneSwitch: UISwitch!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var joinedLabel: UILabel!
    
    //MARK: - Helper Methods
    
    //add delegate as self to textfields
    func setupTextFields() {
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        companyTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
        spouseTextField.delegate = self
    }
    
    //Update Email Label
    func updateEmailHiddenLabel() {
        guard let me = me else { return }
        
        if me.emailHidden {
            emailShownLabel.text = "Email: Hidden"
        } else {
            emailShownLabel.text = "Email: Shown"
        }
    }
    
    //Update Phone Label
    func updatePhoneHiddenLabel() {
        guard let me = me else { return }
        
        if me.phoneHidden {
            phoneShownLabel.text = "Phone: Hidden"
        } else {
            phoneShownLabel.text = "Phone: Shown"
        }
    }
    
    //update UI labels, switches, textFields, textView, image
    func updateUI() {
        guard let me = me else { return }
        
        nameTextField.text = me.firstName
        lastNameTextField.text = me.lastName
        companyTextField.text = me.companyName
        phoneTextField.text = me.phone
        emailTextField.text = me.email
        spouseTextField.text = me.spouseName
        profileImage.image = me.photo
        businessTextView.text = me.businessProfile
        statusLabel.text = "Status: \(me.status == nil ? "" : me.status!.rawValue)"
        updatePhoneHiddenLabel()
        updateEmailHiddenLabel()
        emailSwitch.setOn(!me.emailHidden, animated: false)
        phoneSwitch.setOn(!me.phoneHidden, animated: false)
        //format the date to extract the year
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        joinedLabel.text = "Joined: \(dateFormatter.string(from: me.yearJoined as Date))"
    }
    
    //MARK: - Delegate Methods
    
    //BusinessProfileEdited Delegate Method
    func businessProfileDidChange(newText: String) {
        businessTextView.text = newText
    }
    
    //Image Picker Delegate Method, set the imageView to the image the user selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        self.profileImage.image = image
        dismiss(animated: true, completion: nil)
    }
    
    //Closes the keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        //with this guard statment, ensure that the firstname, lastname, and company text are supplied
        guard let me = me,
            let firstName = nameTextField.text,
            let lastName = lastNameTextField.text,
            let company = companyTextField.text,
            let phone = phoneTextField.text,
            let email = emailTextField.text,
            let spouse = spouseTextField.text,
            let photo = profileImage.image,
            let businessInfo = businessTextView.text, firstName.characters.count > 0 &&
                lastName.characters.count > 0 && company.characters.count > 0 else { return }
        
        //update me object in shared PersonController to reflect saved changes
        PersonController.shared.updateMe(firstName: firstName, lastName: lastName, photo: photo, companyName: company, phone: phone, email: email, spouseName: spouse, businessProfile: businessInfo, emailHidden: me.emailHidden, phoneHidden: me.phoneHidden)
        
        //Remove view from navigation stack
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    //Toggle Email Hidden, update UI
    @IBAction func emailSwitchTapped(_ sender: UISwitch) {
        guard let me = me else { return }
        me.emailHidden = !sender.isOn
        updateEmailHiddenLabel()
    }
    
    //Toggle Phone Hidden, update UI
    @IBAction func phoneSwitchTapped(_ sender: UISwitch) {
        guard let me = me else { return }
        me.phoneHidden = !sender.isOn
        updatePhoneHiddenLabel()
    }
    
    //Change Photo Action, present options for user to change photo (Cancel, Camera, Photo Library)
    @IBAction func changePhotoButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alert = UIAlertController(title: "Select Image Source", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let photoAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        alert.addAction(photoAction)
        alert.addAction(cameraAction)
        self.present(alert, animated: true, completion: nil)
    }

    //MARK: - Segue Method
    
    //Assign the delegate as "self" in the EditBusinessProfileViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditBusinessProfile" {
            if let destinationVC = segue.destination as? EditBusinessProfileViewController {
                destinationVC.delegate = self
            }
        }
    }

}
