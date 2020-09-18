//
//  SubsListQueryModel.swift
//  GAMBAS
//
//  Created by Songhee Choi on 2020/09/18.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

//프로토콜 ---
protocol SubsListQueryModelProtocol: class{
    func subsListItemDownloaded(items:NSArray)
}

protocol ContentsListQueryModelProtocol: class{
    func contentsListItemDownloaded(items:NSArray)
}

//---------

class SubsListQueryModel: NSObject{
    
    var delegate: SubsListQueryModelProtocol!
    var urlPath = "http://localhost:8080/gambas/subsListQuery.jsp"
    
    func subsListdownloadItems(uSeqno: String?){
        print("받은uSeqno", uSeqno!)
        // urlPath 뒤에 ? 물음표 부터 뒤에 넣을 것 세팅
        let urlAdd = "?uSeqno=\(String(uSeqno!))"
        urlPath += urlAdd
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil { // 에러코드가 없을 때 실행
                print("Failed to download data")
            }else{
                print("SubsList Data is downloaded")
                
                //parse JSON
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
           
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print("subsList",error)
        }
            
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary // 제일 처음 중괄호 묶여있는 데이터 jsonResult[i]> 0번으로 들어와있고 > Dictionary로 바꿔주고
            let query = SubscribeDBModel()
            
            if  let subsSeqno = jsonElement["subsSeqno"] as? String,
                let subsRegistDate = jsonElement["subsRegistDate"] as? String,
                let subsValidation = jsonElement["subsValidation"] as? String,
                let uSeqno = jsonElement["uSeqno"] as? String,
                let prdSeqno = jsonElement["prdSeqno"] as? String,
                let term = jsonElement["term"] as? String,
                let releaseDay = jsonElement["releaseDay"] as? String,
                let prdTitle = jsonElement["prdTitle"] as? String,
                let prdPrice = jsonElement["prdPrice"] as? String,
                let prdImage = jsonElement["prdImage"] as? String,
                let prdRegistDate = jsonElement["prdRegistDate"] as? String,
                let cgSeqno = jsonElement["cgSeqno"] as? String,
                let chSeqno = jsonElement["chSeqno"] as? String,
                let chContext = jsonElement["chContext"] as? String,
                let chNickname = jsonElement["chNickname"] as? String,
                let chImage = jsonElement["chImage"] as? String,
                let chValidation = jsonElement["chValidation"] as? String,
                let createrUSeqno = jsonElement["createrUSeqno"] as? String
            
            {
                query.subsSeqno = subsSeqno
                query.subsRegistDate = subsRegistDate
                query.subsValidation = subsValidation
                query.uSeqno = uSeqno
                query.prdSeqno = prdSeqno
                query.term = term
                query.releaseDay = releaseDay
                query.prdTitle = prdTitle
                query.prdPrice = prdPrice
                query.prdImage = prdImage
                query.prdRegistDate = prdRegistDate
                query.cgSeqno = cgSeqno
                query.chSeqno = chSeqno
                query.chContext = chContext
                query.chNickname = chNickname
                query.chImage = chImage
                query.chValidation = chValidation
                query.createrUSeqno = createrUSeqno
            }
            
            // 배열에 넣어줌
            locations.add(query)
        }
        
        // 프로토콜로 전달
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.subsListItemDownloaded(items: locations)
        })
        
    }
    
}//----



class ContentsListQueryModel: NSObject{
    
    var delegate: ContentsListQueryModelProtocol!
    var urlPath = "http://localhost:8080/gambas/contentsListQuery.jsp"
    
    func contentsListdownloadItems(prdSeqno: String?){
        print("받은prdSeqno", prdSeqno!)
        // urlPath 뒤에 ? 물음표 부터 뒤에 넣을 것 세팅
        let urlAdd = "?prdSeqno=\(String(prdSeqno!))"
        urlPath += urlAdd
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil { // 에러코드가 없을 때 실행
                print("Failed to download data")
            }else{
                print("Contents List Data is downloaded")
                
                //parse JSON
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
           
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print("contentslist",error)
        }
            
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary // 제일 처음 중괄호 묶여있는 데이터 jsonResult[i]> 0번으로 들어와있고 > Dictionary로 바꿔주고
            let query = SubscribeDBModel()
            
            if  let ctSeqno = jsonElement["ctSeqno"] as? String,
                let ctTitle = jsonElement["ctTitle"] as? String,
                let ctContext = jsonElement["ctContext"] as? String,
                let ctfile = jsonElement["ctfile"] as? String,
                let ctRegistDate = jsonElement["ctRegistDate"] as? String,
                let ctValidation = jsonElement["ctValidation"] as? String,
                let prdSeqno = jsonElement["prdSeqno"] as? String,
                let ctReleaseDate = jsonElement["ctReleaseDate"] as? String
            
            {
                query.ctSeqno = ctSeqno
                query.ctTitle = ctTitle
                query.ctContext = ctContext
                query.ctfile = ctfile
                query.ctRegistDate = ctRegistDate
                query.ctValidation = ctValidation
                query.prdSeqno = prdSeqno
                query.ctReleaseDate = ctReleaseDate
               
            }
            
            // 배열에 넣어줌
            locations.add(query)
        }
        
        // 프로토콜로 전달
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.contentsListItemDownloaded(items: locations)
        })
        
    }
    
}//----
