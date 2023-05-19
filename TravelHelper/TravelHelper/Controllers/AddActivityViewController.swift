//
//  AddActivityViewController.swift
//  TravelHelper
//
//  Created by Qin Geng on 5/10/23.
//

import UIKit

class AddActivityViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var newActivityCreated: (_ newActivity: Activity) -> Void = { arg in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onCancelButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddActivityButtonClick(_ sender: UIButton) {
        
        // Checking if the task created is empty
        if titleTextField.text?.count == 0 {
            let alert = UIAlertController(title: "Ouch...!", message: "You must create an activity to add it", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Accept", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Passing the created task to the TableView controller
        let activity: Activity = Activity(title: titleTextField.text!, date: datePicker.date, isDone: false)
        newActivityCreated(activity)
        self.dismiss(animated: true, completion: nil)
    }
    
}


