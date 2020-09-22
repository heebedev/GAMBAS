//
//  prdDetailQueryModel.swift
//  GAMBAS
//
//  Created by sookjeon on 2020/09/17.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation
protocol prdDetailQueryModelProtocol {
    func itemDownloaded(items:NSArray)
}

class prdDetailQueryModel: NSObject{
        var delegate: prdDetailQueryModelProtocol!
        var urlPath = "http://localhost:8080/test/gambas_prdInfo_query.jsp"
    func downloadItems(prdSeqno:String, uSeqno:String){
            let urlAdd = "?prdSeqno=\(prdSeqno)&uSeqno=\(uSeqno)"  // urlPath 뒤에 ? 물음표 부터 뒤에 넣을 것 세팅
            urlPath += urlAdd
            let url: URL = URL(string: urlPath)!
            let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
            let task = defaultSession.dataTask(with: url){(data, response, error) in
                if error != nil{
                    print("Failed to download data")
                }else{
                    print("Data is downloaded")
                    self.parseJAON(data!)
                }
            }
            task.resume()
        }
        func parseJAON(_ data: Data){
            var jsonResult = NSArray()
            
            do{
                jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            }catch let error as NSError{
                print(error)
            }
            var jsonElement = NSDictionary()
            let locations = NSMutableArray()
            
            for i in 0..<jsonResult.count{
                jsonElement = jsonResult[i] as! NSDictionary
                let query = prdDetailDBModel()
                // 첫번째 중괄호 안의 변수명 값들을 받아옴.
                if let uSeqCount = jsonElement["uSeqCount"] as? String,
                   let chNickName = jsonElement["chNickName"] as? String,
                   let chImage = jsonElement["chImage"] as? String,
                   let chSeqno = jsonElement["chSeqno"] as? String,
                   let chGrade = jsonElement["chGrade"] as? String,
                   let prdImage = jsonElement["prdImage"] as? String,
                   let prdTitle = jsonElement["prdTitle"] as? String,
                   let prdPrice = jsonElement["prdPrice"] as? String,
                   let prdContext = jsonElement["prdContext"] as? String,
                   let sctSeqno = jsonElement["sctSeqno"] as? String,
                   let sctTitle = jsonElement["sctTitle"] as? String,
                   let sctImage = jsonElement["sctImage"] as? String{
                    
                    
                   
                    query.uSeqCount = uSeqCount
                    query.chNickName = chNickName
                    query.chImage = chImage
                    query.chSeqno = chSeqno
                    query.chGrade = chGrade
                    query.prdImage = prdImage
                    query.prdTitle = prdTitle
                    query.prdPrice = prdPrice
                    query.prdContext = prdContext
                    query.sctSeqno = sctSeqno
                    query.sctTitle = sctTitle
                    query.sctImage = sctImage
                    print(uSeqCount)
                    
                    
                }
                
                locations.add(query)
            }
            DispatchQueue.main.async(execute: {() -> Void in
                self.delegate.itemDownloaded(items: locations)
            })
        }
    }// ------------

class prdReviewQueryModel: NSObject{
        var delegate: prdDetailQueryModelProtocol!
        var urlPath = "http://localhost:8080/test/gambas_prdReview_query.jsp"
    func downloadItems(prdSeqno:String, uSeqno:String){
            let urlAdd = "?prdSeqno=\(prdSeqno)&uSeqno=\(uSeqno)"  // urlPath 뒤에 ? 물음표 부터 뒤에 넣을 것 세팅
            urlPath += urlAdd
            let url: URL = URL(string: urlPath)!
            let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
            let task = defaultSession.dataTask(with: url){(data, response, error) in
                if error != nil{
                    print("Failed to download data")
                }else{
                    print("Data is downloaded")
                    self.parseJAON2(data!)
                }
            }
            task.resume()
        }
        func parseJAON2(_ data: Data){
            var jsonResult = NSArray()
            
            do{
                jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            }catch let error as NSError{
                print(error)
            }
            var jsonElement = NSDictionary()
            let locations = NSMutableArray()
            
            for i in 0..<jsonResult.count{
                jsonElement = jsonResult[i] as! NSDictionary
                let query = prdDetailDBModel()
                // 첫번째 중괄호 안의 변수명 값들을 받아옴.
                if let uSeqCount = jsonElement["uSeqCount"] as? String,
                   let rSeqno = jsonElement["rSeqno"] as? String,
                   let rTitle = jsonElement["rTitle"] as? String,
                   let rGrade = jsonElement["rGrade"] as? String,
                   let uName = jsonElement["uName"] as? String{
                    
                    
                    query.uSeqCount = uSeqCount
                    query.rSeqno = rSeqno
                    query.rTitle = rTitle
                    query.rGrade = rGrade
                    query.uName = uName

                    print(uSeqCount)
                    
                    
                }
                
                locations.add(query)
            }
            DispatchQueue.main.async(execute: {() -> Void in
                self.delegate.itemDownloaded(items: locations)
            })
        }
    }// ------------
