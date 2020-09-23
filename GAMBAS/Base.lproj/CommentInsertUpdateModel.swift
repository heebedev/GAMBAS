//
//  CommentInsertUpdateModel.swift
//  GAMBAS
//
//  Created by Songhee Choi on 2020/09/23.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class CommentInsertUpdateModel: NSObject{
    
    var urlPathInsert = "http://localhost:8080/gambas/contentsCommentInsert.jsp"
    
    func InsertItems(uSeqno: String, ctSeqno: String, cmcontext:String){ // 매개변수 값으로 데이터 들어오고 리턴값 Bool로 받음
        let urlAdd = "?uSeqno=\(uSeqno)&ctSeqno=\(ctSeqno)&cmcontext=\(cmcontext)" // urlPath 뒤에 ? 물음표 부터 뒤에 넣을 것 세팅
        urlPathInsert += urlAdd
        
        // 한글 url encoding: url 타입은 한글들어가면 에러나기 때문에 addingPercentEncoding 퍼센트 들어가는걸로 바꿔줘야 함
        urlPathInsert = urlPathInsert.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPathInsert)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil { // 에러코드가 없을 때 실행
                print("Failed to comment insert data")
            }else{
                print("Comment Data is inserted")
            }
        }
        task.resume()
    }
    
    
    // 댓글 삭제 cmValidation = 0 으로 update
    var urlPathUpdate = "http://localhost:8080/gambas/contentsCommentUpdate.jsp"
    
    func UpdateItems(cmSeqno: String){ // 매개변수 값으로 데이터 들어오고 리턴값 Bool로 받음
        let urlAdd = "?cmSeqno=\(cmSeqno)" // urlPath 뒤에 ? 물음표 부터 뒤에 넣을 것 세팅
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
