//
//  SKHcashModel.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/10/03.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class skhCashModel: NSObject {
    var ivSKHDate: String?
    var ivSKHPrice: String?
    var ivSKHTitle: String?
    
    override init() {
        <#code#>
    }
    
    init(date: String, price: String, title: String) {
        self.ivSKHDate = date
        self.ivSKHPrice = price
        self.ivSKHTitle = title
    }
}


