//
//  NoticeListModel.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/10/03.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class NoticeListModel: NSObject {
    
    var nName: String?
    var nDetailName: String?
    var nCode: String?
    
    override init() {
    
    }
    
    init(nName:String, nCode:String, nDetailName:String) {
        self.nName = nName
        self.nCode = nCode
        self.nDetailName = nDetailName
    }
    
}
