//
//  MyChannelProductEditViewController.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/22.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import Firebase

class MyChannelProductEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{

    
    
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
    
    @IBOutlet weak var pvLJHProductEditCategory: UIPickerView!
    
    let categorySeqnos = [1,2,3,4,5]
    let categoryNames = ["글", "그림", "영상", "음악", "기타"]
    
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
    
    var selectedUrl:URL?
    var selectedName = ""
    var selectedUrl1:URL?
    var selectedName1:String?
    
    let imagePickerController = UIImagePickerController()
    
    var selectCategorySeqno = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        
        imagePickerController.delegate = self
        
        //
        //
        //Firebase image download
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imgRef = storageRef.child("prdImage").child(receiveChannelImage)
        print("Subs Table View \(receiveChannelImage)")
        
        imgRef.getData(maxSize: 1 * 1024 * 1024) {data, error in
            if error != nil {

            } else {
                self.ivLJHChannelEditImage.image = UIImage(data: data!)
            }
        }
        //
        //
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
            pvLJHProductEditCategory.isHidden = true
            
        }else{
            //
            //
            //Firebase image download
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let imgRef = storageRef.child("prdImage").child(receiveProductImage)
            print("Subs Table View \(receiveProductImage)")
            
            imgRef.getData(maxSize: 1 * 1024 * 1024) {data, error in
                if error != nil {

                } else {
                    self.ivLJHProductEditImage?.image = UIImage(data: data!)
                }
            }
            //
            //
            tfLJHProductEditName.text = receiveProductTitle
            tfLJHProductEditContent.text = receiveProductContent
            tfLJHProductEditCategory.text = receiveProductCategoryName
            tfLJHProductEditRegisterDate.text = receiveProductRegisterDate
            tfLJHProductEditTerm.text = receiveProductTerm
            tfLJHProductEditDay.text = receiveProductReleaseDay
            tfLJHProductEditPrice.text = receiveProductPrice
            buttonLJHProductRegister.isHidden = true
            buttonLJHProductDelete.isHidden = false
            pvLJHProductEditCategory.selectRow((Int(receiveProductCategorySeqno ) ?? 1 - 1), inComponent:0, animated:true)
        }
        

        
        print("viewDidLoad()")
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryNames.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryNames[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectCategorySeqno = String(row + 1)
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
        let imageRoutCheckAlert =  UIAlertController(title: "이미지 업로드", message: "어디서 가져올까요?", preferredStyle: .actionSheet)
        let libraryAction =  UIAlertAction(title: "앨범", style: .default, handler: { ACTION in
            if(UIImagePickerController .isSourceTypeAvailable(.photoLibrary)){
                self.imagePickerController.sourceType = .photoLibrary
                self.imagePickerController.mediaTypes = ["public.image"]
                self.present(self.imagePickerController, animated: false, completion: nil)
            } else {
                print("Library not available")
            }
        })
        let cameraAction =  UIAlertAction(title: "카메라", style: .default, handler: { ACTION in
            if(UIImagePickerController .isSourceTypeAvailable(.camera)){
                self.imagePickerController.sourceType = .camera
                self.imagePickerController.mediaTypes = ["public.image"]
                self.present(self.imagePickerController, animated: false, completion: nil)
            } else {
                print("Camera not available")
            }
        })
        let imgCancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        imageRoutCheckAlert.addAction(libraryAction)
        imageRoutCheckAlert.addAction(cameraAction)
        imageRoutCheckAlert.addAction(imgCancelAction)
        present(imageRoutCheckAlert, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            var url:URL?
            switch mediaType {
            case "public.image":
                url = info[UIImagePickerController.InfoKey.imageURL] as? URL
                do {
                    if #available(iOS 13, *) {
                        //If on iOS13 slice the URL to get the name of the file
                        var fireURL = url
                        let urlString = url!.relativeString
                        let urlSlices = urlString.split(separator: ".")
                        //Create a temp directory using the file name
                        let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
                        fireURL = tempDirectoryURL.appendingPathComponent(String(urlSlices[1]))
                        try FileManager.default.copyItem(at: url!, to: fireURL!)
                        url = fireURL!
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            default:
                break
            }
            selectedUrl = url
            
            selectedName = selectedUrl!.lastPathComponent
        }
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            
            ivLJHProductEditImage.image = image
        }
        
        // 켜놓은 앨범 화면 없애기
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func btnLJHChannelEditOk(_ sender: UIButton) {
        
        let channelSeqno = receiveChannelSeqno
        let channelImage = receiveChannelImage
        
        let channelName = tfLJHCannelEditName.text!
        let channelContent = tfLJHCannelEditContent.text!
        
        let productSeqno = receiveProductSeqno
        var productImage = receiveProductImage
        if selectedName.isEmpty {
            
        }else{
            //
            //
            let storage1 = Storage.storage()
            let storageRef1 = storage1.reference()
            
            // File located on disk
            let localFile1 = selectedUrl1
            
            //이미지 이름을 위한 dataformat
            let now1 = NSDate()
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyyMMddHHmmssEEE"
            let dateNow1 = dateFormatter1.string(from: now1 as Date)
            
            productImage = dateNow1 + selectedName
            print("productImage : " + productImage)
            
            // Create a reference to the file you want to upload
            let fileRef1 = storageRef1.child("contentsFolder/" + productImage)
            
            // Upload the file to the path "images/rivers.jpg"
            fileRef1.putFile(from: localFile1!, metadata: nil)
            //
            //
        }
        let productName = tfLJHProductEditName.text!
        let productContent = tfLJHProductEditContent.text!
        let productCategory = selectCategorySeqno
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
        
        if segue.identifier == "sgMyProductRegister" {
            let myProductRegisterViewController = segue.destination as! MyProductRegisterViewController
            myProductRegisterViewController.receiveItems_myChannelSeqno(receiveChannelSeqno)
        }
    }
        

}//----
