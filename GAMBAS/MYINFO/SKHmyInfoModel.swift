//
//  SKHmyInfoModel.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/09/18.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class SKHmyInfoModel: NSObject {
    
    var ivSKHemail: String?
    var ivSKHpassword: String?
    var ivSKHname: String?
    var ivSKHphone: String?
    var ivSKHimage: String?
    var ivSKHinterestCategory: String?
    var ivSKHcount: String?
    
    override init() {
        
    }
    
    init(email: String, name: String, phone: String, image: String, interestCategory: String) {
        
        self.ivSKHemail = email
        self.ivSKHname = name
        self.ivSKHphone = phone
        self.ivSKHimage = image
        self.ivSKHinterestCategory = interestCategory
    }
    
    init(count: String) {
        self.ivSKHcount = count
    }
}
