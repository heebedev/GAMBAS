//
//  NoticeListQueryModel.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/10/03.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

protocol NoticeListQueryModelProtocol: class {
    func listItemDownloaded(items:NSArray)
    func userNameDownloaded(uName:String)
}

class NoticeListQueryModel: NSObject {
    
    var delegate: NoticeListQueryModelProtocol!
    var urlPath = ""
    var uName = ""
    
    func getUserName(userSeqno: String) {
        urlPath = "http://localhost:8080/gambas/UserName_query_ios.jsp?uSeqno=\(userSeqno)"
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("Failed to download data")
            } else {
                print("Data is downloaded")
                self.parseJSON(data: data!, code: "name")
            }
        }
        task.resume()
    }
    
    func downloadItems(userSeqno: String) {
        
        urlPath = "http://localhost:8080/gambas/NoticeList_query_ios.jsp?uSeqno=\(userSeqno)"
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("Failed to download data")
            } else {
                print("Data is downloaded")
                self.parseJSON(data: data!, code: "list")
            }
        }
        task.resume()
    }
    
    func parseJSON(data: Data, code: String) {
        switch code {
        case "name":
            let jsonResult = String(data: data, encoding: .utf8)!
            self.uName = jsonResult
            DispatchQueue.main.async(execute: {() -> Void in
                self.delegate.userNameDownloaded(uName: self.uName)
            })
            break
        default:
            var jsonResult = NSArray()
            do {
                jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            } catch let error as NSError {
                print(error)
            }
            var jsonElement = NSDictionary()
            let items = NSMutableArray()
            
            for i in 0..<jsonResult.count {
                print(jsonResult.count)
                jsonElement = jsonResult[i] as! NSDictionary
                let query = NoticeListModel()
                
                if let nCode = jsonElement["nCode"] as? String,
                    let nDetailName = jsonElement["nDetailName"] as? String,
                    let nName = jsonElement["nName"] as? String {
                    
                    query.nName = nName
                    query.nDetailName = nDetailName
                    query.nCode = nCode
                }
                items.add(query)
            }
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.delegate.listItemDownloaded(items: items)
            })
            break
        }
        
        
    }
    
    
}
