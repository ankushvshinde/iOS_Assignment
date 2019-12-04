//
//  HelperMethods.swift
//  Demo
//
//  Created by Ankush Shinde on 04/12/19.
//  Copyright © 2019 Ankush Shinde. All rights reserved.
//

import UIKit
import MBProgressHUD

class HelperMethods: NSObject {

    //MARK:- Custom functions -
    //Show Alert
    
    class func showAlert(title : String, msg : String, btnTitle : String, onViewController : UIViewController) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: UIAlertAction.Style.default, handler: nil))
        onViewController.present(alert, animated: true, completion: nil)
    }
    
    //Add Progress Indicator
    class func addHUD(onViewController : UIViewController) {
       
        let spinnerActivity = MBProgressHUD.showAdded(to: onViewController.view, animated: true)
        spinnerActivity.label.text = "Loading"
        spinnerActivity.label.textColor = UIColor.black
        spinnerActivity.isUserInteractionEnabled = true
    }
    
    //Stop Progress Indicator
    class func removeHUD(onViewController : UIViewController) {
        
        MBProgressHUD.hide(for: onViewController.view, animated: true)
    }
}
