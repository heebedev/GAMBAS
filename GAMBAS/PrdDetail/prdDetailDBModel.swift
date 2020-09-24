//
//  prdDetailDBModel.swift
//  GAMBAS
//
//  Created by sookjeon on 2020/09/17.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class prdDetailDBModel:NSObject{
    
    var uSeqCount: String?
    var chSeqno: String?
    var chNickName: String?
    var chGrade: String?
    var chImage: String?
    var prdImage: String?
    var prdTitle: String?
    var prdPrice: String?
    var prdContext: String?
    var rTitle: String?
    var rSeqno: String?
    var rGrade: String?
    var uName: String?
    var sctSeqno: String?
    var sctTitle: String?
    var sctImage: String?

    override init() {
        
    }
    init(uSeqCount:String, chSeqno:String, chNickName:String, chGrade:String, chImage:String, prdImage:String, prdTitle:String, prdPrice:String, prdContext:String, rTitle:String, rSeqno:String, uName:String, sctSeqno:String, sctTitle:String, sctImage:String){
        self.uSeqCount = uSeqCount
        self.chSeqno = chSeqno
        self.chNickName = chNickName
        self.chGrade = chGrade
        self.chImage = chImage
        self.prdImage = prdImage
        self.prdTitle = prdTitle
        self.prdPrice = prdPrice
        self.prdContext = prdContext
        self.rTitle = rTitle
        self.rSeqno = rSeqno
        self.uName = uName
        self.sctSeqno = sctSeqno
        self.sctTitle = sctTitle
        self.sctImage = sctImage
    }
    
    init(uSeqCount:String, chSeqno:String, chNickName:String, chGrade:String, chImage:String, prdImage:String, prdTitle:String, prdPrice:String, prdContext:String, sctSeqno:String, sctTitle:String, sctImage:String){
        self.uSeqCount = uSeqCount
        self.chSeqno = chSeqno
        self.chNickName = chNickName
        self.chGrade = chGrade
        self.chImage = chImage
        self.prdImage = prdImage
        self.prdTitle = prdTitle
        self.prdPrice = prdPrice
        self.prdContext = prdContext
        self.sctSeqno = sctSeqno
        self.sctTitle = sctTitle
        self.sctImage = sctImage
    }
    init(rTitle:String, rSeqno:String, rGrade:String, uName:String){
        self.rTitle = rTitle
        self.rSeqno = rSeqno
        self.rGrade = rGrade
        self.uName = uName
    }
}
