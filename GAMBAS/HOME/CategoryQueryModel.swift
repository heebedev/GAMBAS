//
//  MainQueryModel.swift
//  SSAK30
//
//  Created by Songhee Choi on 2020/09/08.
//  Copyright © 2020 김승희. All rights reserved.
//

import Foundation

protocol QueryModelProtocol: class{
    func itemDownloaded(items:NSArray)
}

class CategoryQueryModel: NSObject{
    
    var delegate: QueryModelProtocol!
    
    func downloadItems(category: String, completion: @escaping (Bool)->()){
        var urlPath = "http://localhost:8080/gambas/getCategoryData.jsp"
        let urlAdd = "?category=\(category)"
        urlPath += urlAdd
        // jsp에서 데이터에 한글이 들어갈 경우
        if let encodedPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url:URL = URL(string: encodedPath) {
            let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
            print(url)
            let task = defaultSession.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    print("Failed to download data")
                } else {
                    print("Data is downloaded")
                    self.parseJSON(data!)
                }
            }
            task.resume()
        }
    }
    
    func downloadRecommendItems(category: String, completion: @escaping (Bool)->()){
        var urlPath = "http://localhost:8080/gambas/getRecommendData.jsp"
        let urlAdd = "?category=\(category)"
        urlPath += urlAdd
        // jsp에서 데이터에 한글이 들어갈 경우
        if let encodedPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url:URL = URL(string: encodedPath) {
            let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
            print(url)
            let task = defaultSession.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    print("Failed to download data")
                } else {
                    print("Data is downloaded")
                    self.parseJSON(data!)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary // 제일 처음 중괄호 묶여있는 데이터 jsonResult[i]> 0번으로 들어와있고 > Dictionary로 바꿔주고
            let query = CategoryDBModel()
            
            if  let prdSeqno = jsonElement["prdSeqno"] as? String,
                let prdTitle = jsonElement["prdTitle"] as? String,
                let releaseDay = jsonElement["releaseDay"] as? String,
                let term = jsonElement["term"] as? String,
                let prdPrice = jsonElement["prdPrice"] as? String,
                let prdImage = jsonElement["prdImage"] as? String,
                let chNickname = jsonElement["chNickname"] as? String,
                let count = jsonElement["count"] as? String {
                
                query.prdSeqno = prdSeqno
                query.prdTitle = prdTitle
                query.releaseDay = releaseDay
                query.term = term
                query.prdPrice = prdPrice
                query.prdImage = prdImage
                query.chNickname = chNickname
                query.count = count // 구독자수
                
            }
            
            // 배열에 넣어줌
            locations.add(query)
        }
        
        // 프로토콜로 전달
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
        
    }
    
}//----
