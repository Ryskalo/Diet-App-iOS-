//
//  ViewController.swift
//  diet
//
//  Created by Антон Рыскалев on 25.01.15.
//  Copyright (c) 2015 Антон Рыскалев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightField: UITextField!
    
    @IBOutlet weak var heightField: UITextField!
    
    @IBOutlet weak var oldField: UITextField!
    
    @IBOutlet weak var caloriesResult: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        let weight:Float = (weightField.text as NSString).floatValue
        let height:Float = (heightField.text as NSString).floatValue
        let old:Float = (oldField.text as NSString).floatValue
        
        var num = NSNumberFormatter()
        
        switch (self.segmentedControl.selectedSegmentIndex)
        {
        case 0:
            
            let ruleCalories:Float = (10 * weight + 6.25 * height - 5 * old + 5) * 1.2
            
            var cal = num.stringFromNumber(ruleCalories)
            
            caloriesResult.text = cal! + " Calories"
            
            break;
        case 1:
            
            let ruleCalories:Float = (10 * weight + 6.25 * height - 5 * old - 161) * 1.2
            
            var cal = num.stringFromNumber(ruleCalories)
            
            caloriesResult.text = cal! + " Calories"
            
            break;
        default: 
            break; 
        }
    }
}

