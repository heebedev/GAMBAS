//
//  ReviewAddQueryModel.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/09/24.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class ReviewAddQueryModel: NSObject {
    
    func InsertReviewItems(rTitle: String, rContent: String, rGrade: String, subsSeq:String, uSeq:String) {
        var urlPath =  "http://localhost:8080/gambas/PrdReviewInsert.jsp?rTitle=\(rTitle)&rContent=\(rContent)&rGrade=\(rGrade)&subsSeqno=\(subsSeq)&uSeqno=\(uSeq)"
        
        // 한글 url encoding: url 타입은 한글들어가면 에러나기 때문에 addingPercentEncoding 퍼센트 들어가는걸로 바꿔줘야 함
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print(urlPath)
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil { // 에러코드가 없을 때 실행
                print("Failed to insert data")
            } else {
                print("here")
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
}
