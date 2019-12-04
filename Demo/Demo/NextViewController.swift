//
//  NextViewController.swift
//  Demo
//
//  Created by Ankush Shinde on 04/12/19.
//  Copyright © 2019 Ankush Shinde. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class tableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
}

class NextViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var factList = [FactModel]()
    
    //MARK:- View Life Cycle Methods -
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.callAPI()
    }
    
    //MARK:- API Calls Methods -
    
    func callAPI() {
        
        HelperMethods.addHUD(onViewController: self)
        
        //create the url with NSURL
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            let latinString = String(data: data, encoding: .isoLatin1)
            let jsonData = latinString?.data(using: .utf8)
            
            do {
                if let dictInfo = try JSONSerialization.jsonObject(with: jsonData!, options: .mutableLeaves) as? [AnyHashable : Any] {
                    
                    print(dictInfo)
                    self.factList = self.parseFactEntity(dictResponse: dictInfo as AnyObject)
                    DispatchQueue.main.async {
                        
                        HelperMethods.removeHUD(onViewController: self)
                        self.tableView.reloadData()
                    }
                }
            } catch let error {
               
                DispatchQueue.main.async {
                    
                    HelperMethods.removeHUD(onViewController: self)
                }
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func parseFactEntity(dictResponse: AnyObject) -> [FactModel] {
                
        let resp = JSON(dictResponse)
        let response = resp["rows"].array
        var array = [FactModel]()
        
        for element in response! {
        
            let objFact = FactModel.init(strTitle: "", strDescription: "", strImageHref: "")
            
            if let strTitle = element["title"].string {
                
                objFact.title = strTitle
            }
            if let strDescription = element["description"].string {
                
                objFact.factDescription = strDescription
            }
            if let strImageHref = element["imageHref"].string {
                
                objFact.imageHref = strImageHref
            }
            array.append(objFact)
        }
        
        return array
    }
    
    //MARK:- UITableViewCell DataSource Methods -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.factList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! tableViewCell
        
        cell.lblTitle.text = self.factList[indexPath.row].title
        cell.lblDescription.text = self.factList[indexPath.row].factDescription
        cell.imgView!.sd_setImage(with: URL(string: self.factList[indexPath.row].imageHref), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
}
