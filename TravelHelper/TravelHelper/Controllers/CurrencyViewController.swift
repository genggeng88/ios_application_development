//
//  CurrencyViewController.swift
//  TravelHelper
//
//  Created by Qin Geng on 5/9/23.
//

import UIKit

class CurrencyViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromTextField: UITextField!
    
    var pickerData: [String] = [String]()
    var responseData: CurrencyResponseData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        pickerData = ["CAD", "HKD", "ISK", "PHP", "DKK", "HUF", "CZK", "AUD", "RON", "SEK", "IDR", "INR", "BRL", "RUB", "HRK", "JPY", "THB", "CHF", "SGD", "PLN", "BGN", "TRY", "CNY", "NOK", "NZD", "ZAR", "USD", "MXN", "ILS", "GBP", "KRW", "MYR"]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.toLabel.text = "0 \(pickerData[row])"
        
        return pickerData[row]
    }
    
    @IBAction func convertButtonClicked(_ sender: Any) {
        let from: String = fromTextField.text!
        let amount: Double = Double(amountTextField.text!) ?? 0
        let to: String = pickerData[pickerView!.selectedRow(inComponent: 0)]
        
        CurrencyAPIHandler.shared.fetchCurrencyInfo(from: from, to: to, amount: amount) { (response) in
            print("Stop loading")
            self.responseData = response
            print(response)
            let exchangeDate: String = (self.responseData?.date)!
            print(exchangeDate)
            let exchangeResult: Double = (self.responseData?.result)!
            print(exchangeResult)
            
            DispatchQueue.main.async {
                self.toLabel.text = "\(exchangeResult) on DATE: \(exchangeDate)"
            }
        }
    }
}
