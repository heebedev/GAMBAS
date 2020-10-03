//
//  AddSubscribeQueryModel.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/09/28.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

protocol AddSubscribeQueryModelProtocol: class {
    func addSubsResultDownloaded(result: Bool)
}

class AddSubscribeQueryModel: NSObject {
    
    var delegate : AddSubscribeQueryModelProtocol!
    
    var urlPath: String = ""
    
    func addSubscribeInsertloadItems(uSeqno: String, prdSeqno: String, code:String) {
        
        var result = false
        
        if code == "add" {
            urlPath = "http://127.0.0.1:8080/gambas/subscribe_Insert_ios.jsp?uSeqno=\(uSeqno)&prdSeqno=\(prdSeqno)"
        } else {
            urlPath = "http://127.0.0.1:8080/gambas/subscribe_cancel_ios.jsp?uSeqno=\(uSeqno)&prdSeqno=\(prdSeqno)"
        }
        
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print(urlPath)
        
        let url: URL = URL(string: urlPath)!
        let defaultSesstion = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSesstion.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert data")
            } else {
                print("Data is inserted")
                result = true
                
                DispatchQueue.main.async(execute: {() -> Void in
                    self.delegate.addSubsResultDownloaded(result: result)
                })
            }
            
        } //task
        task.resume()
    } //suvscribeInsertloadItems
}
