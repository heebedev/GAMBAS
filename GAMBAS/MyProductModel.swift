//
//  MyProductModel.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/18.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class MyProductModel: NSObject{
    
//    prdSeqno, term, releaseDay, prdTitle, prdPrice, prdContext, prdImage, prdRegistDate, prdValidation, chSeqno, cgSeqno
    
    var prdSeqno: String?
    var term: String?
    var releaseDay: String?
    var prdTitle: String?
    var prdPrice: String?
    var prdContext: String?
    var prdImage: String?
    var prdRegistDate: String?
    var prdValidation: String?
    var chSeqno: String?
    var cgSeqno: String?
    
    override init() {
        
    }
    
    init(prdSeqno: String, term: String, releaseDay: String, prdTitle: String, prdPrice: String, prdContext: String, prdImage: String, prdRegistDate: String, prdValidation: String, chSeqno: String, cgSeqno: String) {
        self.prdSeqno = prdSeqno
        self.term = term
        self.releaseDay = releaseDay
        self.prdTitle = prdTitle
        self.prdPrice = prdPrice
        self.prdContext = prdContext
        self.prdImage = prdImage
        self.prdRegistDate = prdRegistDate
        self.prdValidation = prdValidation
        self.chSeqno = chSeqno
        self.cgSeqno = cgSeqno
    }
    
}//----
