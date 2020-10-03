//
//  SKHcashQueryModel.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/10/03.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

protocol cashQueryModelProtocol: class {
    func itemDownloaded(items: NSArray)
}

class cashQueryModel: NSObject {
    var delegate: cashQueryModelProtocol!
    var urlPath = "http://localhost:8080/gambas/gambas_cash_query_ios.jsp"
    
    func downloadItems(seq: String){
        let urlAdd = "?uSeqno=\(seq)"
        urlPath += urlAdd
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
            } else {
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) {
        var jsonResult = NSArray()
        
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
           
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let query = skhCashModel()
            
            if  let date = jsonElement["date"] as? String,
                let cash = jsonElement["cash"] as? String,
                let title = jsonElement["title"] as? String
                {

                query.ivSKHDate = date
                query.ivSKHPrice = cash
                query.ivSKHTitle = title
            }
            locations.add(query)
            
        }
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
    }
}
