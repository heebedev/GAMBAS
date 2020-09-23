//
//  SubListDBModel.swift
//  GAMBAS
//
//  Created by Songhee Choi on 2020/09/18.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class SubscribeDBModel: NSObject{
    
    // Properties
    var subsSeqno: String?
    var subsRegistDate: String?
    var subsValidation: String?
    var uSeqno: String?
    var prdSeqno: String?
    var term: String?
    var releaseDay: String?
    var prdTitle: String?
    var prdPrice: String?
    var prdImage: String?
    var prdRegistDate: String?
    var cgSeqno: String?
    var chSeqno: String?
    var chContext: String?
    var chNickname: String?
    var chImage: String?
    var chValidation: String?
    var createrUSeqno: String?
    var cgName: String?
    
    // ContentsList 추가
    var ctSeqno: String?
    var ctTitle: String?
    var ctContext: String?
    var ctfile: String?
    var ctRegistDate: String?
    var ctValidation: String?
    var ctReleaseDate: String?
    
    // contentview like 추가
    var countlikecontents: String?
    var checkmylikecontents: String?
    
    // 댓글 리스트 list 추가
    var cmSeqno: String?
    var cmcontext: String?
    var cmRegistDate: String?
    var cmValidation: String?
    var uName: String?
    
    
    
    //Empty Constructor
    override init() {
    }
    
    // Constructor : SubsList
    init(subsSeqno: String, subsRegistDate:String, subsValidation:String, uSeqno:String, prdSeqno: String, term:String, releaseDay:String, prdTitle:String, prdPrice: String, prdImage:String, prdRegistDate:String, cgSeqno: String, chSeqno:String, chContext:String, chNickname: String, chImage:String, chValidation: String, createrUSeqno: String, cgName: String) {
        self.subsSeqno = subsSeqno
        self.subsRegistDate = subsRegistDate
        self.subsValidation = subsValidation
        self.prdSeqno = prdSeqno
        self.uSeqno = uSeqno
        self.term = term
        self.releaseDay = releaseDay
        self.prdTitle = prdTitle
        self.prdPrice = prdPrice
        self.prdImage = prdImage
        self.prdRegistDate = prdRegistDate
        self.cgSeqno = cgSeqno
        self.chSeqno = chSeqno
        self.chContext = chContext
        self.chNickname = chNickname
        self.chImage = chImage
        self.chValidation = chValidation
        self.createrUSeqno = createrUSeqno
        self.cgName = cgName
    }
    
    // Constructor : contetns List
    init(ctSeqno: String, ctTitle:String, ctContext:String, ctfile:String, ctRegistDate: String, ctValidation:String, prdSeqno:String, ctReleaseDate:String) {
        self.ctSeqno = ctSeqno
        self.ctTitle = ctTitle
        self.ctContext = ctContext
        self.ctfile = ctfile
        self.ctRegistDate = ctRegistDate
        self.ctValidation = ctValidation
        self.prdSeqno = prdSeqno
        self.ctReleaseDate = ctReleaseDate
    }
    
    // Constructor : contetns View (좋아요 갯수 포함)
    init(ctSeqno: String, ctTitle:String, ctContext:String, ctfile:String, ctRegistDate: String, ctValidation:String, prdSeqno:String, ctReleaseDate:String, countlikecontents:String, checkmylikecontents: String) {
        self.ctSeqno = ctSeqno
        self.ctTitle = ctTitle
        self.ctContext = ctContext
        self.ctfile = ctfile
        self.ctRegistDate = ctRegistDate
        self.ctValidation = ctValidation
        self.prdSeqno = prdSeqno
        self.ctReleaseDate = ctReleaseDate
        self.countlikecontents = countlikecontents
        self.checkmylikecontents = checkmylikecontents
        
    }
    
    // Constructor : 댓글리스트
    init(cmSeqno: String, cmcontext:String, cmRegistDate:String, cmValidation:String, ctSeqno: String, uSeqno:String, uName:String) {
        self.cmSeqno = cmSeqno
        self.cmcontext = cmcontext
        self.cmRegistDate = cmRegistDate
        self.cmValidation = cmValidation
        self.ctSeqno = ctSeqno
        self.uSeqno = uSeqno
        self.uName = uName
    }
    
    
    
}//---
