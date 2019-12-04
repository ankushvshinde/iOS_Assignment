//
//  FactModel.swift
//  Demo
//
//  Created by Ankush Shinde on 04/12/19.
//  Copyright © 2019 Ankush Shinde. All rights reserved.
//

import UIKit

class FactModel: NSObject {

    var title: String = ""
    var factDescription: String = ""
    var imageHref: String = ""

    init(strTitle: String, strDescription: String, strImageHref: String) {
       
        self.title = strTitle
        self.factDescription = strDescription
        self.imageHref = strImageHref
    }
}
