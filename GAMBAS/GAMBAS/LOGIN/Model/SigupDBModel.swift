//
//  SigupDBModel.swift
//  GAMBAS
//
//  Created by TJ on 21/09/2020.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation
class SigupDBModel: NSObject {
    
    var uSepno : String?
    var uEmail : String?
    var uPassword:String?
    var uName: String?
    var uBirth:String?
    var Phone:String?
    var Image:String?
    var CreaterSubs:String?
    var uRegistDate:String?
    var uValidation:String?
    var interestCategory:String?
    
    
    override init(){
        
    }
    
    init(uSepno:String,uEmail:String,uPassword:String,uName:String,uBirth:String,Phone:String,Image:String,CreaterSubs:String,uRegistDate:String,uValidation:String,interestCategory:String){
        self.uSepno = uSepno
        self.uEmail = uEmail
        self.uPassword = uPassword
        self.uName = uName
        self.uBirth = uBirth
        self.Phone = Phone
        self.Image = Image
        self.CreaterSubs = CreaterSubs
        self.uRegistDate = uRegistDate
        self.uValidation = uValidation
        self.interestCategory = interestCategory
    }
    
    
}
