//
//  SigupInsertDBModel.swift
//  GAMBAS
//
//  Created by TJ on 21/09/2020.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation

protocol SignupInsertDBModelProtocol: class {
    func signupResultDownloaded(result: Bool)
}

class SigupInsertDBModel:NSObject{
    
    var delegate : SignupInsertDBModelProtocol!
    
    var urlPath = "http://127.0.0.1:8080/gambas/Userinfo_Insert_ios.jsp"
    func signUpInsertloadItems(Email: String, Password: String, Name: String, Birth: String, Phone: String, Image: String, interestCategory:String){
        var insertResult = false
        
        let urlAdd = "?Email=\(Email)&Password=\(Password)&Name=\(Name)&Birth=\(Birth)&Phone=\(Phone)&Image=\(Image)&interestCategory=\(interestCategory)"
        urlPath += urlAdd
        
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print(urlPath)
        
        let url: URL = URL(string: urlPath)!
        let defaultSesstion = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSesstion.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert data")
            } else {
                print("Data is inserted")
                insertResult = true
                DispatchQueue.main.async(execute: {() -> Void in
                    print("delegate \(String(insertResult))")
                    self.delegate.signupResultDownloaded(result: insertResult)
                    print("delegate \(String(insertResult))")
                })
            }
            
        }
        task.resume()
    }
    
}
