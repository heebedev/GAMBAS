//
//  MyContentsAddViewController.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/22.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import Firebase

class MyContentsAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    
    
    @IBOutlet weak var tfLJHContentsAddTitle: UITextField!
    @IBOutlet weak var tvLJHContentsAddContent: UITextView!
    @IBOutlet weak var btnFileUpload: UIButton!
    @IBOutlet weak var lbKSHFileRegistered: UILabel!
    @IBOutlet weak var tvKSHFileName: UITextView!
    
    var selectedUrl:URL?
    var selectedName:String?
    
    let imagePickerController = UIImagePickerController()
    let documentPickerController = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
    
    var receiveProductSeqno = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        // Do any additional setup after loading the view.
        
        lbKSHFileRegistered.isHidden = true
        tvKSHFileName.isHidden = true
        
        tvLJHContentsAddContent.layer.borderWidth = 1
        tvLJHContentsAddContent.layer.borderColor = UIColor.systemGray5.cgColor
        tvLJHContentsAddContent.layer.cornerRadius = 5
        tvLJHContentsAddContent.layer.masksToBounds = true
        
        documentPickerController.delegate = self
        documentPickerController.modalPresentationStyle = .fullScreen
        self.present(documentPickerController, animated: true, completion: nil)
    }
    
    
    func receiveItems_myProductSeqno(_ productSeqno: String){
        receiveProductSeqno = productSeqno
        print("receiveItems_myProductSeqno()" + receiveProductSeqno)
    }
    
    
    @IBAction func btnLJHContentsAddFile(_ sender: UIButton) {
        let fileRoutCheckAlert =  UIAlertController(title: "파일 업로드", message: "파일을 가져올 방식을 선택하세요.", preferredStyle: .actionSheet)
        let imageAction =  UIAlertAction(title: "이미지", style: .default, handler: { ACTION in
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
            self.present(imageRoutCheckAlert, animated: true, completion: nil)
        })
        let movieAction =  UIAlertAction(title: "동영상", style: .default, handler: { ACTION in
            if(UIImagePickerController .isSourceTypeAvailable(.photoLibrary)){
                self.imagePickerController.sourceType = .photoLibrary
                self.imagePickerController.mediaTypes = ["public.movie"]
                self.present(self.imagePickerController, animated: false, completion: nil)
            } else {
                print("Library not available")
            }
        })
        let fileAction =  UIAlertAction(title: "파일", style: .default, handler: { ACTION in
            self.present(self.documentPickerController, animated: false, completion: nil)
        })
        let fileCancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        fileRoutCheckAlert.addAction(imageAction)
        fileRoutCheckAlert.addAction(movieAction)
        fileRoutCheckAlert.addAction(fileAction)
        fileRoutCheckAlert.addAction(fileCancelAction)
        present(fileRoutCheckAlert, animated: true, completion: nil)
    }
    

    
    
    @IBAction func btnLJHContentsAddOk(_ sender: UIButton) {
        
        var contentsFile = ""
        let contentsTitle = tfLJHContentsAddTitle.text!
        let contentsContent = tvLJHContentsAddContent.text!
        let productSeqno = receiveProductSeqno
        
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
        
        contentsFile = dateNow + selectedName!
        print("*****" + contentsFile)
        
        // Create a reference to the file you want to upload
        let fileRef = storageRef.child("contentsFolder/" + contentsFile)
        
        // Upload the file to the path "images/rivers.jpg"
        fileRef.putFile(from: localFile!, metadata: nil)
        //
        //
        // firebase
        //
        //
        
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
            dismiss(animated: true, completion: nil)
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
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            var url:URL?
            switch mediaType {
            case "public.image":
                url = info[UIImagePickerController.InfoKey.imageURL] as? URL
            case "public.movie":
                url = info[UIImagePickerController.InfoKey.mediaURL] as? URL
                do {
                    if #available(iOS 13, *) {
                        //If on iOS13 slice the URL to get the name of the file
                        var fireURL = url
                        let urlString = url!.relativeString
                        let urlSlices = urlString.split(separator: ".")
                        //Create a temp directory using the file name
                        let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
                        fireURL = tempDirectoryURL.appendingPathComponent(String(urlSlices[1])).appendingPathExtension(String(urlSlices[2]))
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
        // 켜놓은 앨범 화면 없애기
        lbKSHFileRegistered.isHidden = false
        tvKSHFileName.isHidden = false
        tvKSHFileName.text = selectedName
        btnFileUpload.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let fileURL = urls.first else {
            return
        }
        selectedUrl = fileURL
        selectedName = selectedUrl?.lastPathComponent
        lbKSHFileRegistered.isHidden = false
        tvKSHFileName.isHidden = false
        tvKSHFileName.text = selectedName
        btnFileUpload.isHidden = true
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
