//
//  SKHmyInfoDeleteModel.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/09/23.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

class SKHmyInfopwDeleteModel: NSObject {
    
    var urlPath = "http://localhost:8080/gambas/SKHmyInfoUser_validation.jsp"
    
    func SKHmyInfoUpdateItems(seq: String) -> Bool {
        var result: Bool = true
        let urlAdd = "?uSeqno=\(seq)"
        
        urlPath += urlAdd
        
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        print("url \(url)")
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
