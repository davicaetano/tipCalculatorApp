//
//  SettingsViewController.swift
//  Teste
//
//  Created by Davi on 12/14/15.
//  Copyright © 2015 Davi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var rate1: UITextField!
    @IBOutlet weak var rate2: UITextField!
    @IBOutlet weak var rate3: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewWillDisappear(animated: Bool) {
        defaults.setDouble(Double(rate1.text!)!, forKey: "rate1")
        defaults.setDouble(Double(rate2.text!)!, forKey: "rate2")
        defaults.setDouble(Double(rate3.text!)!, forKey: "rate3")
        defaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = self.view.backgroundColor
        rate1.text = String(format: "%g", defaults.doubleForKey("rate1"))
        rate2.text = String(format: "%g", defaults.doubleForKey("rate2"))
        rate3.text = String(format: "%g", defaults.doubleForKey("rate3"))
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip")
    }
    @IBAction func tipControlChanged(sender: UISegmentedControl) {
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "defaultTip")
    }
}
