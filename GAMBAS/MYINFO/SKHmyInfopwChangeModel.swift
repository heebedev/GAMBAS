//
//  SKHmyInfopwChangeModel.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/09/19.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

// 내 감바스 -> 내정보수정 -> 수정된 정보 업데이트 위해 사용

class SKHmyInfopwChangeModel: NSObject {
    
    var urlPath = "http://localhost:8080/gambas/SKHmyInfoPwChange.jsp"
    
    func SKHmyInfoUpdateItems(password: String, seq: String) -> Bool {
        var result: Bool = true
        let urlAdd = "?uPassword=\(password)&uSeqno=\(seq)"
        
        urlPath += urlAdd
        
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSesseion = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSesseion.dataTask(with: url) {(data, response, error) in
            if error != nil {
                print("failed to insert data")
                result = false
            } else {
                print("Data is downloaded")
                result = true
            }
        }
        task.resume()
        
        return result
    }
}
