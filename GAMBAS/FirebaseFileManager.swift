//
//  FirebaseFileManager.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/09/22.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation
import Firebase

class FirebaseFileManager: NSObject {
    
    let storage = Storage.storage()
    
    
    func FileUpload(folderName: String, fileName: String, fileData: Data) {
        
        let fileRef = storage.reference().child(folderName).child(fileName)
        
        _ = fileRef.putData(fileData, metadata: nil)
        
    }
    
    func FileDownload(folderName: String, fileName: String) -> String {
        var returnUrl:String = ""
        
        let pathReference = storage.reference().child(folderName).child(fileName)
        
        pathReference.downloadURL { (url, error) in
            if let error = error {
                print(error)
            } else {
                returnUrl = url!.absoluteString
            }
        }
        
        return returnUrl
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
