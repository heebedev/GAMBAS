//
//  MyLikeListModel.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/10/03.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

protocol MyLikeListQueryModelProtocol: class {
    func myLikeDownloaded(likes:NSArray)
}

class MyLikeListQueryModel: NSObject {
    
    var delegate: MyLikeListQueryModelProtocol!
    var urlPath = ""
    
    func likeDownloadItems(uSeqno:String) {
        urlPath = "http://localhost:8080/gambas/MyLikeList_ios.jsp?uSeqno=\(uSeqno)"
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("Failed to download data")
            } else {
                print("Data is downloaded")
                self.parseJSON(data: data!)
            }
        }
        task.resume()
    }
    
    func parseJSON(data: Data) {
        var jsonResult = NSArray()
        
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let items = NSMutableArray()
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            let query = LikeReviewModel()
            
            if let title = jsonElement["title"] as? String,
               let subTitle = jsonElement["subTitle"] as? String {
                
                query.title = title
                query.subTitle = subTitle
                
                print("\(title), \(subTitle)")
            }
            items.add(query)
        }
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.myLikeDownloaded(likes: items)
        })
        
    }
    
}

