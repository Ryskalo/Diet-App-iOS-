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
    @IBOutlet weak var nameProduct: UITextField!
    @IBOutlet weak var protProduct: UITextField!
    @IBOutlet weak var fatProduct: UITextField!
    @IBOutlet weak var carbProduct: UITextField!
    @IBOutlet weak var calProduct: UITextField!
    @IBOutlet weak var status: UILabel!
    
    
    var databasePath = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filemgr = NSFileManager.defaultManager()
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        println("\(dirPaths)")
        
        let docsDir = dirPaths[0] as String
        
        databasePath = docsDir.stringByAppendingPathComponent("products.db")
        
        if !filemgr.fileExistsAtPath(databasePath) {
            
            let productDB = FMDatabase(path: databasePath)
            
            
            if productDB == nil {
                println("Error: \(productDB.lastErrorMessage())")
            }
            
            if productDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS PRODUCTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, PROT TEXT, FAT TEXT, CARB TEXT, CAL TEXT, IMAGE TEXT)"
                if !productDB.executeStatements(sql_stmt) {
                    println("Error: \(productDB.lastErrorMessage())")
                }
                productDB.close()
            } else {
                println("Error: \(productDB.lastErrorMessage())")
            }
        }
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
     /*
       //     var data : NSMutableDictionary = NSMutableDictionary(contentsOfFile: path!)!
            
            var object = ["Calor" : "ruleCalories"]
            
            var path = NSBundle.mainBundle().pathForResource("Products", ofType: "plist")
            
            var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            var path = paths.stringByAppendingPathComponent("Products.plist")
            var fileManager = NSFileManager.defaultManager()
            if (!(fileManager.fileExistsAtPath(path)))
            {
                var bundle : NSString = NSBundle.mainBundle().pathForResource("Products", ofType: "plist")!
                fileManager.copyItemAtPath(bundle, toPath: path, error:nil)
            }
            
            //var data : NSMutableDictionary = NSMutableDictionary(contentsOfFile: path!)!
            
         //   data.setObject(object, forKey: "Calor")
          //  data.writeToFile(path!, atomically: true)
            
          //  var name:AnyObject! = data.objectForKey("Calor")
            
          //  println("\(name)") 

        */
            
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
    
    @IBAction func addProductBtn(sender: AnyObject) {
        
        let productDB = FMDatabase(path: databasePath)
        
        if productDB.open() {
            
            let insertSQL = "INSERT INTO PRODUCTS (name, prot, fat, carb, cal, image) VALUES ('\(nameProduct.text)', '\(protProduct.text)', '\(fatProduct.text)', '\(carbProduct.text)', '\(calProduct.text)', '152-512.png')"
            
            let result = productDB.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if !result {
                status.text = "Failed to add contact"
                println("Error: \(productDB.lastErrorMessage())")
                
                
            } else {
                status.text = "Contact Added"
            }
        } else {
            println("Error: \(productDB.lastErrorMessage())")
        }
        
    }
    
}

