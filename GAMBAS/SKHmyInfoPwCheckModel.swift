//
//  SKHmyInfoPwCheckModel.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/09/19.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

protocol SkhmyInfoModelProtocol: class {
    func itemDownloaded(items: String)
}

class SkhmyInfoPwCheckModel: NSObject {
    var delegate: SkhmyInfoModelProtocol!
    var urlPath = "http://localhost:8080/gambas/SKHmyInfoPwCheck.jsp"
    
    func checkCount(password: String, seq: Int){
        let urlAdd = "?uPassword=\(password)&uSeqno=\(seq)"
        urlPath += urlAdd
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("failed to download data")
            } else {
                print("Data is downloaded")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
        
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        var jsonElement = NSDictionary()
        var resultCheck = ""
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            
            if let count = jsonElement["check"] as? String {
                resultCheck = count
                print("SKHmyInfoPWCHECK \(resultCheck)")
            }
            
        }
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: resultCheck)
        })
    }
}
