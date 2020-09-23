//
//  MyContentsAddViewController.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/22.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class MyContentsAddViewController: UIViewController {
    
    @IBOutlet weak var tfLJHContentsAddTitle: UITextField!
    @IBOutlet weak var tvLJHContentsAddContent: UITextView!
    
    var receiveProductSeqno = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func receiveItems_myProductSeqno(_ productSeqno: String){
        receiveProductSeqno = productSeqno
        print("receiveItems_myProductSeqno()" + receiveProductSeqno)
    }
    
    
    @IBAction func btnLJHContentsAddFile(_ sender: UIButton) {
    }
    
    
    @IBAction func btnLJHContentsAddOk(_ sender: UIButton) {
        
        let contentsFile = ""
        let contentsTitle = tfLJHContentsAddTitle.text!
        let contentsContent = tvLJHContentsAddContent.text!
        let productSeqno = receiveProductSeqno

        
        let url: URL = URL(string: "http://127.0.0.1:8080/gambas/MyContentsInsert.jsp?contentsFile=\(contentsFile)&contentsTitle=\(contentsTitle)&contentsContent=\(contentsContent)&productSeqno=\(productSeqno)")!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{ // '에러 코드가 있었다'라는 걸 의미
                print("Failed to insert data")
            }else{
                print("Product is added")
            }
        }
        task.resume()
        
        let resultAlert = UIAlertController(title: "완료", message: "컨텐츠가 등록되었습니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { [self]ACTION in
            self.navigationController?.popViewController(animated: true)
        })
        resultAlert.addAction(okAction)
        present(resultAlert, animated: true, completion: nil)
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
