//
//  LoginQuaryModel.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/09/21.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

protocol LoginQuaryModelProtocol: class {
    func LoginChkDownloaded(uSeqno: String, uResult: String, uCreatorCode: String)
}

class LoginQuaryModel: NSObject {
    

    var delegate: LoginQuaryModelProtocol!
    
    // 로그인 아이디비밀번호확인
    func IdCheckItems(_ uEmail:String){
        print("HERE")
        let urlPath = "http://localhost:8080/gambas/LoginChk_ios.jsp?uEmail=\(uEmail)"  // urlPath 뒤에 ? 물음표 부터 뒤에 넣을 것 세팅
        print(urlPath)
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
            }else{
                self.parseJAON(data!)
            }
        }
        
        task.resume()
    }

    func parseJAON(_ data: Data){
        
        var jsonResult = NSArray()
        
        var falseOrPw = "false"
        var uSeqnoResult = "0"
        var uCreatorCode = "1"
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        var jsonElement = NSDictionary()

        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary
            // 첫번째 중괄호 안의 변수명 값들을 받아옴.
            if let uSeq = jsonElement["uSeqno"] as? String,
               
               let ckResult = jsonElement["result"] as? String,
            let uCreaterSubs = jsonElement["uCreaterSubs"] as? String{
                
                
                uSeqnoResult = uSeq
                falseOrPw = ckResult
                uCreatorCode = uCreaterSubs
            
            }

        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.LoginChkDownloaded(uSeqno: uSeqnoResult, uResult: falseOrPw, uCreatorCode : uCreatorCode)
        })
    }
    
}
