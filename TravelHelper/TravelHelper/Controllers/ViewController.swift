//
//  ViewController.swift
//  TravellerTap
//
//  Created by Qin Geng on 5/6/23.
//

import UIKit
import Firebase
import FirebaseAuth

protocol SignupLoginDelegate: AnyObject {
    func loginSuccess(email: String)
}

class ViewController: UIViewController, SignupLoginDelegate {
    
    var loggedIn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if the user is already logged in
        if loggedIn {
            navigateToTabBar()
        } else {
            // User is not logged in, show the signup/login screen
//            showSignupLoginScreen()
            DispatchQueue.main.async {
                self.showSignupLoginScreen()
            }
        }
        
    }
    
    func showSignupLoginScreen() {
        let storyboard = UIStoryboard(name: "SignupLogin", bundle: nil)
        let signupLoginVC = storyboard.instantiateViewController(withIdentifier: "SignupLoginViewController") as! SignupLoginViewController
        signupLoginVC.delegate = self // Set the delegate to receive the login success event
        present(signupLoginVC, animated: true, completion: nil)
    }
    
    func navigateToTabBar() {
        let tabBarVC = tabBarVC()
            
        addChild(tabBarVC)
        view.addSubview(tabBarVC.view)
        tabBarVC.didMove(toParent: self)
        
        // Set the frame for the tab bar controller's view
        tabBarVC.view.frame = view.bounds
        tabBarVC.tabBar.backgroundColor = .gray
    }
    
    func tabBarVC() -> UITabBarController {
        let tabBarVC = UITabBarController()
        
        let storyboard1 = UIStoryboard(name: "Home", bundle: nil)
        let vc1 = storyboard1.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let storyboard2 = UIStoryboard(name: "Currency", bundle: nil)
        let vc2 = storyboard2.instantiateViewController(withIdentifier: "CurrencyViewController") as! CurrencyViewController
        
        let storyboard3 = UIStoryboard(name: "Activity", bundle: nil)
        let vc3 = storyboard3.instantiateViewController(withIdentifier: "ActivityViewController") as! ActivityViewController
        
        let storyboard4 = UIStoryboard(name: "Map", bundle: nil)
        let vc4 = storyboard4.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        let storyboard5 = UIStoryboard(name: "Profile", bundle: nil)
        let vc5 = storyboard5.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController

        vc1.title = "Home"
        vc2.title = "Convert Currency"
        vc3.title = "Create Activities"
        vc4.title = "Search Locations"
        vc5.title = "Profile"
        
        let navVC1 = UINavigationController(rootViewController: vc1)
        let navVC2 = UINavigationController(rootViewController: vc2)
        let navVC3 = UINavigationController(rootViewController: vc3)
        let navVC4 = UINavigationController(rootViewController: vc4)
        let navVC5 = UINavigationController(rootViewController: vc5)
        
        
        tabBarVC.setViewControllers([navVC1, navVC2, navVC3, navVC4, navVC5], animated: true)
        
        if let items = tabBarVC.tabBar.items {
            let titles = ["Home", "Currency", "Activity", "Map", "Profile"]
            let images = ["house", "dollarsign.circle", "plus", "map", "person.circle"]
            for i in 0..<items.count {
                items[i].title = titles[i]
                items[i].image = UIImage(systemName: images[i])
                items[i].selectedImage = UIImage(systemName: images[i] + ".fill")
            }
        }
        return tabBarVC
    }
    
    func loginSuccess(email: String) {
        loggedIn = true
        print("Log in success with the user's email address: \(email)")
//        dismiss(animated: true, completion: nil)
        navigateToTabBar()
    }
}

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



