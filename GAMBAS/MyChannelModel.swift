//
//  MyChannelModel.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/18.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class MyChannelModel: NSObject{
    
//    chSeqno, chContext, chNickname, chImage, chRegistDate, chValidation, uSeqno
    
    var chSeqno: String?
    var chContext: String?
    var chNickname: String?
    var chImage: String?
    var chRegistDate: String?
    var chValidation: String?
    var uSeqno: String?
    
    override init() {
        
    }
    
    init(chSeqno: String, chContext: String, chNickname: String, chImage: String, chRegistDate: String, chValidation: String, uSeqno: String) {
        self.chSeqno = chSeqno
        self.chContext = chContext
        self.chNickname = chNickname
        self.chImage = chImage
        self.chRegistDate = chRegistDate
        self.chValidation = chValidation
        self.uSeqno = uSeqno
    }
    
}//----
