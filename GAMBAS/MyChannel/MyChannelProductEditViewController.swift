//
//  MyChannelProductEditViewController.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/22.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class MyChannelProductEditViewController: UIViewController {
    
    @IBOutlet weak var ivLJHChannelEditImage: UIImageView!
    @IBOutlet weak var tfLJHCannelEditName: UITextField!
    @IBOutlet weak var tfLJHCannelEditRegisterDate: UITextField!
    @IBOutlet weak var tfLJHCannelEditContent: UITextField!
    
    @IBOutlet weak var ivLJHProductEditImage: UIImageView!
    @IBOutlet weak var tfLJHProductEditName: UITextField!
    @IBOutlet weak var tfLJHProductEditContent: UITextField!
    @IBOutlet weak var tfLJHProductEditCategory: UITextField!
    @IBOutlet weak var tfLJHProductEditRegisterDate: UITextField!
    @IBOutlet weak var tfLJHProductEditTerm: UITextField!
    @IBOutlet weak var tfLJHProductEditDay: UITextField!
    @IBOutlet weak var tfLJHProductEditPrice: UITextField!
    
    @IBOutlet weak var buttonLJHProductEditImage: UIButton!
    
    @IBOutlet weak var buttonLJHProductRegister: UIButton!
    @IBOutlet weak var buttonLJHProductDelete: UIButton!
    
    var receiveChannelSeqno = ""
    var receiveChannelContent = ""
    var receiveChannelName = ""
    var receiveChannelImage = ""
    var receiveChannelRegisterDate = ""
    var receiveChannelValidation = ""
    
    var receiveProductSeqno = ""
    var receiveProductTerm = ""
    var receiveProductReleaseDay = ""
    var receiveProductTitle = ""
    var receiveProductPrice = ""
    var receiveProductContent = ""
    var receiveProductImage = ""
    var receiveProductRegisterDate = ""
    var receiveProductValidation = ""
    var receiveProductCategorySeqno = ""
    var receiveProductCategoryName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        ivLJHChannelEditImage
        tfLJHCannelEditName.text = receiveChannelName
        tfLJHCannelEditRegisterDate.text = receiveChannelRegisterDate
        tfLJHCannelEditContent.text = receiveChannelContent
        
        if receiveProductSeqno.isEmpty {
            
            ivLJHProductEditImage.isHidden = true
            buttonLJHProductEditImage.isHidden = true
            tfLJHProductEditName.isHidden = true
            tfLJHProductEditContent.isHidden = true
            tfLJHProductEditCategory.isHidden = true
            tfLJHProductEditRegisterDate.isHidden = true
            tfLJHProductEditTerm.isHidden = true
            tfLJHProductEditDay.isHidden = true
            tfLJHProductEditPrice.isHidden = true
            buttonLJHProductRegister.isHidden = false
            buttonLJHProductDelete.isHidden = true
            
        }else{
    //        ivLJHProductEditImage
            tfLJHProductEditName.text = receiveProductTitle
            tfLJHProductEditContent.text = receiveProductContent
            tfLJHProductEditCategory.text = receiveProductCategoryName
            tfLJHProductEditRegisterDate.text = receiveProductRegisterDate
            tfLJHProductEditTerm.text = receiveProductTerm
            tfLJHProductEditDay.text = receiveProductReleaseDay
            tfLJHProductEditPrice.text = receiveProductPrice
            buttonLJHProductRegister.isHidden = true
            buttonLJHProductDelete.isHidden = false
        }
        
        print("viewDidLoad()")
    }
    
    

    func receiveItems_myChannelProduct(_ channelSeqno: String, _ channelContent: String, _ channelName: String, _ channelImage: String, _ channelRegisterDate: String, _ channelValidation: String, _ productSeqno: String, _ productTerm: String, _ productReleaseDay: String, _ productTitle: String, _ productPrice: String, _ productContent: String, _ productImage: String, _ productRegisterDate: String, _ productValidation: String, _ productCategorySeqno: String, _ productCategoryName: String){
        
        receiveChannelSeqno = channelSeqno
        receiveChannelContent = channelContent
        receiveChannelName = channelName
        receiveChannelImage = channelImage
        receiveChannelRegisterDate = channelRegisterDate
        receiveChannelValidation = channelValidation
        
        receiveProductSeqno = productSeqno
        receiveProductTerm = productTerm
        receiveProductReleaseDay = productReleaseDay
        receiveProductTitle = productTitle
        receiveProductPrice = productPrice
        receiveProductContent = productContent
        receiveProductImage = productImage
        receiveProductRegisterDate = productRegisterDate
        receiveProductValidation = productValidation
        receiveProductCategorySeqno = productCategorySeqno
        receiveProductCategoryName = productCategoryName
        
        print("receiveItems_myChannelProduct()" + channelContent)
    }
    
    @IBAction func btnLJHChannelEditImage(_ sender: UIButton) {
    }
    
    @IBAction func btnLJHProductEditImage(_ sender: UIButton) {
    }
    
    
    
    @IBAction func btnLJHChannelEditOk(_ sender: UIButton) {
        print("0000")
        
        let channelSeqno = receiveChannelSeqno
        let channelImage = "***"
        let channelName = tfLJHCannelEditName.text!
        let channelContent = tfLJHCannelEditContent.text!
        
        let productSeqno = receiveProductSeqno
        let productImage = "***"
        let productName = tfLJHProductEditName.text!
        let productContent = tfLJHProductEditContent.text!
        let productCategory = tfLJHProductEditCategory.text!
        let productTerm = tfLJHProductEditTerm.text!
        let productDay = tfLJHProductEditDay.text!
        let productPrice = tfLJHProductEditPrice.text!
        
        let url: URL = URL(string: "http://127.0.0.1:8080/gambas/MyChannelProductUpdate.jsp?channelName=\(channelName)&channelContent=\(channelContent)&productName=\(productName)&productContent=\(productContent)&productCategory=\(productCategory)&productTerm=\(productTerm)&productDay=\(productDay)&productPrice=\(productPrice)&channelImage=\(channelImage)&channelSeqno=\(channelSeqno)&productSeqno=\(productSeqno)&productImage=\(productImage)")!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{ // '에러 코드가 있었다'라는 걸 의미
                print("Failed to update data")
            }else{
                print("Channel and Product were updated")
            }
        }
        task.resume()
        
        let resultAlert = UIAlertController(title: "알림", message: "수정이 완료되었습니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { [self]ACTION in
            self.navigationController?.popViewController(animated: true)
        })
        resultAlert.addAction(okAction)
        present(resultAlert, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func btnLJHProductDelete(_ sender: UIButton) {
        
        let productDeleteAlert = UIAlertController(title: "알림", message: "상품을 삭제하면 상품 안의 모든 컨텐츠가 삭제됩니다. 정말 삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        // Closure를 이용한 실행
        let deleteAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: { [self]ACION in

            let url: URL = URL(string: "http://127.0.0.1:8080/gambas/MyProductDelete.jsp?productSeqno=\(receiveProductSeqno)")!
            let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
            
            let task = defaultSession.dataTask(with: url){(data, response, error) in
                if error != nil{ // '에러 코드가 있었다'라는 걸 의미
                    print("Failed to delete data")
                }else{
                    print("Product is removed")
                }
            }
            task.resume()
            
            navigationController?.popViewController(animated: true)
            
        })
        let cancelAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.default, handler: nil)
        // 붙이는 갯수만큼 나옴.
        productDeleteAlert.addAction(deleteAction)
        productDeleteAlert.addAction(cancelAction)
        present(productDeleteAlert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnLJHProductRegister(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "sgMyProductRegister"{
            let myProductRegisterViewController = segue.destination as! MyProductRegisterViewController

            myProductRegisterViewController.receiveItems_myChannelSeqno(receiveChannelSeqno)
            
            print("prepare()")
        }
    }
        

}//----
