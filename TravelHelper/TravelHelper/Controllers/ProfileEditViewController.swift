//
//  ProfileEditViewController.swift
//  TravelHelper
//
//  Created by Qin Geng on 5/15/23.
//

import UIKit

protocol ProfileEditViewControllerDelegate: AnyObject {
    func didUpdateProfile(name: String, bio: String)
}

class ProfileEditViewController: UIViewController {
   
    weak var delegate: ProfileEditViewControllerDelegate?

    @IBOutlet weak var profileNameTextField: UITextField!
    @IBOutlet weak var profileBioTextField: UITextField!
    
    @IBAction func profileEditCancelClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func profileEditSaveClick(_ sender: Any) {
        let name = profileNameTextField.text ?? "Not Set Yet"
        let bio = profileBioTextField.text ?? "Not Set Yet"
        
        delegate?.didUpdateProfile(name: name, bio: bio)
        print("delegate?.didUpdateProfile(name: name, bio: bio) is called with name: \(name) and bio: \(bio)")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
