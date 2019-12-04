//
//  ViewController.swift
//  Demo
//
//  Created by Ankush Shinde on 04/12/19.
//  Copyright © 2019 Ankush Shinde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- View Life Cycle Methods -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK:- Button Action Methods -
    
    @IBAction func pushViewControllerTapped(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextViewController") as! NextViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

