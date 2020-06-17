//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

//MARK: - Main Class
class ViewController: UIViewController{
    
    @IBOutlet weak var pickerValue: UIPickerView!
    @IBOutlet weak var labelMoney: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerValue.dataSource = self
        pickerValue.delegate = self
        coinManager.delegate = self
    }
}


//MARK: - UIPickerView DataSource & Delegate
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let moneyType = coinManager.currencyArray[row]
        print(moneyType)
        
        coinManager.fetchValue(moneyType: moneyType)
    }
}

//MARK: - CoinManagerDelegate
protocol CoinManagerDelegate {
    func didFailWithError(_ error: Error)
    func didDataUpdate(_ data: ByteCoinData)
}

extension ViewController: CoinManagerDelegate {
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    func didDataUpdate(_ data: ByteCoinData) {
        DispatchQueue.main.async {
            self.labelMoney.text = data.asset_id_quote
            self.labelValue.text = String(format: "%.2f", data.rate)
        }
    }
}

