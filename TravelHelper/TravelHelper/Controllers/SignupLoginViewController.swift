//
//  SignupLoginViewController.swift
//  TravelHelper
//
//  Created by Qin Geng on 5/13/23.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupLoginViewController: UIViewController {
    
    weak var delegate: SignupLoginDelegate?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup code if needed
    }
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil{
                if let errorCode = AuthErrorCode.Code(rawValue: (error as NSError?)?.code ?? 0) {
                    switch errorCode {
                    case .emailAlreadyInUse:
                        self.showAlert(message: "This email address is already signed up. Please log in.")
                    case .invalidEmail:
                        self.showAlert(message: "Invalid email address. Please enter a valid email.")
                    case .weakPassword:
                        self.showAlert(message: "Password should be at least six characters long.")
                    default:
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("Unknown error occurred")
                        }
                        // Handle other registration errors, e.g., display an error message to the user
                    }
                }
            }
            else {
                self.loginSuccess()
            }
        }
    }
    
    
    @IBAction func logInButtonClicked(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                if let errorCode = AuthErrorCode.Code(rawValue: (error as NSError?)?.code ?? 0) {
                    switch errorCode {
                    case .userNotFound:
                        self.showAlert(message: "This email address is not signed up yet. Please sign up first.")
                    case .wrongPassword:
                        self.showAlert(message: "Wrong password. Please enter the correct password.")
                    case .invalidEmail:
                        self.showAlert(message: "The email address is badly formatted. Please enter a valid email address.")
                    default:
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("Unknown error occurred")
                        }
                        // Handle other login errors, e.g., display an error message to the user
                    }
                }
            }
            else {
                self.loginSuccess()
            }
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func loginSuccess() {
        guard let email = emailTextField.text else {
            return
        }
        delegate?.loginSuccess(email: email)
        print("delegate?.loginSuccess(email: email) got called in the SignupLoginViewController!")
        self.dismiss(animated: true, completion: nil)
    }
}
