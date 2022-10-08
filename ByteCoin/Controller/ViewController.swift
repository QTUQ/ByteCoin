//
//  ViewController.swift
//  ByteCoin
//


import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var currencyLable: UILabel!
    @IBOutlet weak var bitcoinLable: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
 
    var coinManger = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManger.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    
}
//Mark: - coinMangerDelegate

extension ViewController: CoinMangerDelegate {
    
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
        self.currencyLable.text = currency
        self.bitcoinLable.text = price
    }
    
}
    func didFailWithError(error: Error) {
        print(error)
    }
}


//Mark: - UIPickerViewDataSource, UIPickerViewDelegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManger.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManger.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let coin = coinManger.currencyArray[row]
        return coinManger.getCoinPrice(for: coin)
    }
    
}



