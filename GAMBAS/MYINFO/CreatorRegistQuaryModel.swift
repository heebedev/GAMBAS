//
//  CreatorRegistQuaryModel.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/10/04.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class CreatorRegistQuaryModel: NSObject {
    
    func registItems(uSeqno: String, uCreatorCode: String){ // 매개변수 값으로 데이터 들어오고 리턴값 Bool로 받음
        var urlPath = "http://localhost:8080/gambas/CreatorRegist_ios.jsp?uSeqno=\(uSeqno)&uCreaterSubs=\(uCreatorCode)" // urlPath 뒤에 ? 물음표 부터 뒤에 넣을 것 세팅

        // 한글 url encoding: url 타입은 한글들어가면 에러나기 때문에 addingPercentEncoding 퍼센트 들어가는걸로 바꿔줘야 함
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
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
}
