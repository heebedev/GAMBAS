//
//  KakaoLoginQueryModel.swift
//  SSAK30
//
//  Created by sookjeon on 2020/09/12.
//  Copyright © 2020 김승희. All rights reserved.
//

import Foundation

protocol KakaoLoginQueryModelProtocol: class {
    func itemDownloaded(uSeqno: String)
}

class KakaoLoginQueryModel: NSObject{
    
    var delegate: KakaoLoginQueryModelProtocol!
    var urlPath = "http://localhost:8080/test/gambas_kakaologin_query.jsp"
    
    func downloadItems(uEmail:String){
        let urlAdd = "?uEmail=\(uEmail)"  // urlPath 뒤에 ? 물음표 부터 뒤에 넣을 것 세팅
        urlPath += urlAdd
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
        var resultSeqno:String?
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        var jsonElement = NSDictionary()
        
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary
            
            // 첫번째 중괄호 안의 변수명 값들을 받아옴.
            if let uSeqno = jsonElement["uSeqno"] as? String{
               
                resultSeqno = uSeqno
                
                
            }
            
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(uSeqno: resultSeqno!)
        })
    }
}// ------------
