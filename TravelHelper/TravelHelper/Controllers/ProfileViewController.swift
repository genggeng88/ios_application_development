//
//  ProfileViewController.swift
//  TravellerTap
//
//  Created by Qin Geng on 5/6/23.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBAction func editProfileImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditProfileSegue" {
            print("sugue is found!!")
            if let editProfileVC = segue.destination as? ProfileEditViewController {
                editProfileVC.delegate = self
                print("editProfileVC.delegate = self is implemented")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = max(profileImage.frame.size.width, profileImage.frame.size.height) / 2.0
        profileImage.layer.masksToBounds = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided with the following: \(info)")
        }
        
        // Update the profile image view with the selected image
        profileImage.image = selectedImage
        
        // Dismiss the image picker controller
        dismiss(animated: true, completion: nil)
    }
}


extension ProfileViewController: ProfileEditViewControllerDelegate {
    func didUpdateProfile(name: String, bio: String) {
        nameLabel.text = "Name: "+name
        bioLabel.text = "Bio: "+bio
        // Save the name and bio values in Core Data
        let coreDataUserStore = CoreDataUserStore()
        let user = User(name: name, bio: bio, date: Date())
        coreDataUserStore.save(user: user, name: user.name, bio: user.bio)
    }
}
