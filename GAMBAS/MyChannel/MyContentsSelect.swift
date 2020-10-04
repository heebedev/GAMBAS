//
//  MyContentsSelect.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/18.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

// 이 쿼리모델과 테이블뷰 연결해주는 프로토콜 하나 필요함.
// 프로토콜은 따로 스위프트 만들어서 써도 됨.
protocol MyContentsSelectProtocol: class {
    // 함수
    func itemDownload_myContents(itemContents: NSArray)
}


class MyContentsSelect: NSObject{
    
    var delegate: MyContentsSelectProtocol!
    var urlPath = "http://127.0.0.1:8080/gambas/"
    
    func downloadItem_myContents(productSeqno: String) {
        // 에러 처리용.
     
        
        let urlAdd = "MyContentsSelect.jsp?productSeqno=\(productSeqno)"
        // 완전한 url.
        urlPath += urlAdd
        // 한글 url encoding (utf8이랑 아무런 상관없음)
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print(urlPath)
        
        let url: URL = URL(string: urlPath)!
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{ // '에러 코드가 있었다'라는 걸 의미
                print("콘텐츠리스트 Failed to download data")
      
            }else{
                print("콘텐츠리스트 Data is downloaded")
                /// -->> 파싱해야죠.
                self.parseJSON(data!)
      
            }
        }

        // 구동.
        task.resume()
    }
   
    // 검색 
    func searchItem_myContents(productSeqno : String, keyword : String){
        let urlAdd = "MyContentsSearch.jsp?productSeqno=\(productSeqno)&keyword=\(keyword)"
        urlPath += urlAdd
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{ // '에러 코드가 있었다'라는 걸 의미
                print("Failed to download data")
            }else{
                print("Data is downloaded")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray // 을 어레이 타입으로 바꾼다. (as! NSArray)
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        // 이제 제이슨 하나씩 가져오면 되죠.
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary
            // DBModel 형태로 바꿔줌.
            let query = MyContentsModel()
            
            if let ctSeqno = jsonElement["contentsSeqno"] as? String,
                let ctTitle = jsonElement["contentsTitle"] as? String,
                let ctContext = jsonElement["contentsContent"] as? String,
                let ctfile = jsonElement["contentsFile"] as? String,
                let ctRegistDate = jsonElement["contentsRegisterDate"] as? String,
                let ctValidation = jsonElement["contentsValidation"] as? String,
                let prdSeqno = jsonElement["productSeqno"] as? String,
                let ctReleaseDate = jsonElement["contentsReleaseDate"] as? String{
                
                query.ctSeqno = ctSeqno
                query.ctTitle = ctTitle
                query.ctContext = ctContext
                query.ctfile = ctfile
                query.ctRegistDate = ctRegistDate
                query.ctValidation = ctValidation
                query.prdSeqno = prdSeqno
                query.ctReleaseDate = ctReleaseDate
            }
            // for문 안에 if 문 하나 끝남.
            
            // 로케이션 어레이에 넣어줘야지.
            locations.add(query)
        }
        
        // Async로 넣어준다.
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownload_myContents(itemContents: locations)
        })

    }
    
    
}//----
