//
//  LikeInsertUpdateModel.swift
//  GAMBAS
//
//  Created by Songhee Choi on 2020/09/22.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class LikeInsertUpdateModel: NSObject{
    
    var urlPathInsert = "http://localhost:8080/gambas/contentsLikeInsert.jsp"
    
    func InsertItems(uSeqno: String, ctSeqno: String, prdSeqno: String){ // 매개변수 값으로 데이터 들어오고 리턴값 Bool로 받음
        let urlAdd = "?uSeqno=\(uSeqno)&ctSeqno=\(ctSeqno)&prdSeqno=\(prdSeqno)" // urlPath 뒤에 ? 물음표 부터 뒤에 넣을 것 세팅
        urlPathInsert += urlAdd
        
        // 한글 url encoding: url 타입은 한글들어가면 에러나기 때문에 addingPercentEncoding 퍼센트 들어가는걸로 바꿔줘야 함
        urlPathInsert = urlPathInsert.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPathInsert)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil { // 에러코드가 없을 때 실행
                print("Failed to insert data")
            }else{
                print("Data is inserted")
            }
        }
        task.resume()
    }
    
    
    // 좋아요 취소 : likeValidation = 0 으로 update
    var urlPathUpdate = "http://localhost:8080/gambas/contentsLikeUpdate.jsp"
    
    func UpdateItems(uSeqno: String, ctSeqno: String){ // 매개변수 값으로 데이터 들어오고 리턴값 Bool로 받음
        let urlAdd = "?uSeqno=\(uSeqno)&ctSeqno=\(ctSeqno)" // urlPath 뒤에 ? 물음표 부터 뒤에 넣을 것 세팅
        urlPathUpdate += urlAdd
        
        // 한글 url encoding: url 타입은 한글들어가면 에러나기 때문에 addingPercentEncoding 퍼센트 들어가는걸로 바꿔줘야 함
        urlPathUpdate = urlPathUpdate.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPathUpdate)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil { // 에러코드가 없을 때 실행
                print("Failed to update data")
            }else{
                print("Data is updated")
            }
        }
        task.resume()
    }
    
    
    
}//----
