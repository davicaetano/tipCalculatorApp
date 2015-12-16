//
//  ViewController.swift
//  Teste
//
//  Created by Davi on 12/13/15.
//  Copyright © 2015 Davi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var div1: UILabel!
    @IBOutlet weak var div2: UILabel!
    @IBOutlet weak var div3: UILabel!
    let defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var tipRates : [Double] = []
    let currencyFormat = NSNumberFormatter()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = self.view.backgroundColor
        
        billField.becomeFirstResponder()
        
        var frame = billField.frame
        frame.size.height = 60
        billField.frame = frame
        
        
        currencyFormat.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormat.locale = NSLocale.currentLocale()
        
        let lastTime = defaults.objectForKey("lastTime")
        if lastTime != nil{
            let now = NSDate.timeIntervalSinceReferenceDate()
            let diff = now - (lastTime as! Double)
            if diff < 60 * 10 {
                let billValue = defaults.objectForKey("billValue")
                if billValue != nil{
                    if billValue as! Double != 0 {
                        billField.text = String(billValue!)
                    }
                }
            }
        }
        
        if(billField.text == ""){
            view2.center.y = view.bounds.height * 4 / 3
            billField.center.y = view.bounds.height / 2.7
        }else{
            self.billField.center.y = self.view.bounds.height / 4.7
            self.view2.center.y = self.view.bounds.height / 3 + self.view2.bounds.height/2
        }
        
        tipLabel.text = currencyFormat.stringFromNumber(0)
        totalLabel.text = currencyFormat.stringFromNumber(0)
        div1.text = currencyFormat.stringFromNumber(0)
        div2.text = currencyFormat.stringFromNumber(0)
        div3.text = currencyFormat.stringFromNumber(0)
        
        if defaults.objectForKey("defaultTip") == nil{
            defaults.setDouble(1, forKey: "defaultTip")
        }
        if defaults.objectForKey("rate1") == nil{
            defaults.setDouble(15, forKey: "rate1")
        }
        if defaults.objectForKey("rate2") == nil{
            defaults.setDouble(20, forKey: "rate2")
        }
        if defaults.objectForKey("rate3") == nil{
            defaults.setDouble(25, forKey: "rate3")
        }
        defaults.synchronize()
        
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip")
    }
    
    override func viewWillAppear(animated: Bool) {
        tipRates = [defaults.doubleForKey("rate1"),defaults.doubleForKey("rate2"),defaults.doubleForKey("rate3")]
        tipControl.setTitle(String(format: "%g%%", tipRates[0]), forSegmentAtIndex: 0)
        tipControl.setTitle(String(format: "%g%%", tipRates[1]), forSegmentAtIndex: 1)
        tipControl.setTitle(String(format: "%g%%", tipRates[2]), forSegmentAtIndex: 2)
        onBillFieldChanged(tipControl)
    }


    override func viewWillDisappear(animated: Bool) {
        if billField.text != "" {
            defaults.setDouble(Double(billField.text!)!,forKey: "billValue")
        }else{
            defaults.setDouble(0.0,forKey: "billValue")
        }
        defaults.setDouble(NSDate.timeIntervalSinceReferenceDate(),forKey: "lastTime")
        defaults.synchronize()
    }
    @IBAction func tipControlChanged(sender: AnyObject) {
        onTap(sender)
        onBillFieldChanged(sender)
    }

    @IBAction func onBillFieldChanged(sender: AnyObject) {
        if billField.text != ""{
            UIView.animateWithDuration(0.5, animations: {
                self.billField.center.y = self.view.bounds.height / 4.7
                self.view2.center.y = self.view.bounds.height / 3 + self.view2.bounds.height/2
            })
        }else{
            UIView.animateWithDuration(0.5, animations: {
                self.billField.center.y = self.view.bounds.height / 2.7
                self.view2.center.y = self.view.bounds.height * 4 / 3
            })
        }
        let tipRate = Double(tipRates[tipControl.selectedSegmentIndex])/100
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = tipRate * billAmount
        let total = billAmount + tip
        
        tipLabel.text = currencyFormat.stringFromNumber(tip)
        totalLabel.text = currencyFormat.stringFromNumber(total)
        
        div1.text = currencyFormat.stringFromNumber(total/2)
        div2.text = currencyFormat.stringFromNumber(total/3)
        div3.text = currencyFormat.stringFromNumber(total/4
        )
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

