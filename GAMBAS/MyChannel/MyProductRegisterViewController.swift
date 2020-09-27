//
//  MyProductRegisterViewController.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/22.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import Firebase

class MyProductRegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var ivLJHProductRegisterImage: UIImageView!
    @IBOutlet weak var tfLJHProductRegisterName: UITextField!
    @IBOutlet weak var tfLJHProductRegisterContent: UITextField!
    @IBOutlet weak var pvLJHProductRegisterCategory: UIPickerView!
    @IBOutlet weak var tfLJHProductRegisterTerm: UITextField!
    @IBOutlet weak var tfLJHProductRegisterDay: UITextField!
    @IBOutlet weak var tfLJHProductRegisterPrice: UITextField!
    
    var receiveChannelSeqno = ""
    var receiveProductCategorySeqno = ""
    
    let imagePickerController = UIImagePickerController()
    
    var selectedUrl:URL?
    var selectedName:String?
    
    let categoryNames = ["카테고리 선택하기", "글", "그림", "영상", "음악", "기타"]
    
    var selectCategorySeqno = "5"
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePickerController.delegate = self
        
        pvLJHProductRegisterCategory.selectRow(0, inComponent:0, animated:true)
        
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
        if row == 0{
            selectCategorySeqno = "5"
        }else{
            
        selectCategorySeqno = String(row)
    
        }
    }
    
    func receiveItems_myChannelSeqno(_ channelSeqno: String){
        
        receiveChannelSeqno = channelSeqno
       
        print("receiveItems_myChannelSeqno()" + receiveChannelSeqno)
    }
    
    
    @IBAction func btnLJHProductRegisterImage(_ sender: UIButton) {

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
            selectedName = selectedUrl?.lastPathComponent
        }
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        ivLJHProductRegisterImage.image = image
        }
        
        // 켜놓은 앨범 화면 없애기
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnLJHProductRegisterOk(_ sender: UIButton) {
        
        var productImage = ""
        //
        //
        // firebase
        //
        //
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // File located on disk
        let localFile = selectedUrl
        
        //이미지 이름을 위한 dataformat
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmssEEE"
        let dateNow = dateFormatter.string(from: now as Date)
        
        productImage = dateNow + selectedName!
        print("*****" + productImage)
        
        // Create a reference to the file you want to upload
        let fileRef = storageRef.child("contentsFolder/" + productImage)
        
        // Upload the file to the path "images/rivers.jpg"
        fileRef.putFile(from: localFile!, metadata: nil)
        //
        //
        // firebase
        //
        //
        let productName = tfLJHProductRegisterName.text!
        let productContent = tfLJHProductRegisterContent.text!
        let productCategory = selectCategorySeqno
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
//            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
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
