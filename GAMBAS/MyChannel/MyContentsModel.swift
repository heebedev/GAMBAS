//
//  MyContentsModel.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/18.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class MyContentsModel: NSObject{
    
//    ctSeqno, ctTitle, ctContext, ctfile, ctRegistDate, ctValidation, prdSeqno
    
    var ctSeqno: String?
    var ctTitle: String?
    var ctContext: String?
    var ctfile: String?
    var ctRegistDate: String?
    var ctValidation: String?
    var prdSeqno: String?
    
    override init() {
        
    }
    
    init(ctSeqno: String, ctTitle: String, ctContext: String, ctfile: String, ctRegistDate: String, ctValidation: String, prdSeqno: String) {
        self.ctSeqno = ctSeqno
        self.ctTitle = ctTitle
        self.ctContext = ctContext
        self.ctfile = ctfile
        self.ctRegistDate = ctRegistDate
        self.ctValidation = ctValidation
        self.prdSeqno = prdSeqno
    }
    
}//----
