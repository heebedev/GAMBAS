//
//  MyProductRegisterViewController.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/22.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class MyProductRegisterViewController: UIViewController {
    
    @IBOutlet weak var ivLJHProductRegisterImage: UIImageView!
    @IBOutlet weak var tfLJHProductRegisterName: UITextField!
    @IBOutlet weak var tfLJHProductRegisterContent: UITextField!
    @IBOutlet weak var tfLJHProductRegisterCategory: UITextField!
    @IBOutlet weak var tfLJHProductRegisterTerm: UITextField!
    @IBOutlet weak var tfLJHProductRegisterDay: UITextField!
    @IBOutlet weak var tfLJHProductRegisterPrice: UITextField!
    
    var receiveChannelSeqno = ""
    var receiveProductCategorySeqno = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func receiveItems_myChannelSeqno(_ channelSeqno: String){
        
        receiveChannelSeqno = channelSeqno
       
        print("receiveItems_myChannelSeqno()" + receiveChannelSeqno)
    }
    
    
    @IBAction func btnLJHProductRegisterImage(_ sender: UIButton) {
    }
    
    @IBAction func btnLJHProductRegisterOk(_ sender: UIButton) {
        
        let productImage = ""
        let productName = tfLJHProductRegisterName.text!
        let productContent = tfLJHProductRegisterContent.text!
        let productCategory = tfLJHProductRegisterCategory.text!
        let productTerm = tfLJHProductRegisterTerm.text!
        let productDay = tfLJHProductRegisterDay.text!
        let productPrice = tfLJHProductRegisterPrice.text!
        let channelSeqno = receiveChannelSeqno
        
        let url: URL = URL(string: "http://127.0.0.1:8080/gambas/MyProductInsert.jsp?productTerm=\(productTerm)&productDay=\(productDay)&productName=\(productName)&productPrice=\(productPrice)&productContent=\(productContent)&productImage=\(productImage)&channelSeqno=\(channelSeqno)&productCategory=\(productCategory)")!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{ // '에러 코드가 있었다'라는 걸 의미
                print("Failed to insert data")
            }else{
                print("Product is added")
            }
        }
        task.resume()
        
        let resultAlert = UIAlertController(title: "완료", message: "상품이 등록되었습니다.", preferredStyle: UIAlertController.Style.alert)
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
