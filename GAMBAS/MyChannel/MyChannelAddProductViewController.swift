//
//  MyChannelAddProductViewController.swift
//  GAMBAS
//
//  Created by Songhee Choi on 2020/10/04.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import Firebase

class MyChannelAddProductViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{

    @IBOutlet weak var iv_addPrdImage: UIImageView!
    
    @IBOutlet weak var tf_prdTitle: UITextField!
    @IBOutlet weak var tf_prdPrice: UITextField!
    @IBOutlet weak var tv_prdContext: UITextView!
    
    
    @IBOutlet weak var btn_text: UIButton!
    @IBOutlet weak var btn_picture: UIButton!
    @IBOutlet weak var btn_video: UIButton!
    @IBOutlet weak var btn_music: UIButton!
    @IBOutlet weak var btn_ect: UIButton!
    
    
    @IBOutlet weak var btn_everyday: UIButton!
    @IBOutlet weak var btn_everyweek: UIButton!
    
    @IBOutlet weak var btn_Sun: UIButton!
    @IBOutlet weak var btn_Mon: UIButton!
    @IBOutlet weak var btn_Tue: UIButton!
    @IBOutlet weak var btn_Wed: UIButton!
    @IBOutlet weak var btn_Thu: UIButton!
    @IBOutlet weak var btn_Fri: UIButton!
    @IBOutlet weak var btn_Sat: UIButton!
    
    
    // 이미지 선택
    let imagePickerController = UIImagePickerController()
    var imageURL: URL?
    var imageName: String = ""
    
    var cgSeqnoChecked = [0,0,0,0,0]
    var termChecked = [0,0]
    var releaseDayChecked = [0,0,0,0,0,0,0]
    
    let imgUnchecked = UIImage(named: "unchecked.png")
    let imgChecked = UIImage(named: "checked.png")
    
    
    //AddProduct세그로 받은 내용 
    var receive_chSeqno = ""
    
    
    let storage = Storage.storage() // 파베
    let insertdbModel = SigupInsertDBModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePickerController.delegate = self
        
        iv_addPrdImage.image = UIImage(named: "emptyImage.png")
        self.iv_addPrdImage.layer.cornerRadius = 75
        
        tv_prdContext.layer.borderWidth = 1.0
        tv_prdContext.layer.borderColor = UIColor.systemGray5.cgColor
        
        
        //
        btn_text.tag = 1
        btn_picture.tag = 2
        btn_video.tag = 3
        btn_music.tag = 4
        btn_ect.tag = 5
        
        // term 버튼
        btn_everyday.tag = 6
        btn_everyweek.tag = 7
        
        // 요일 버튼
        btn_Sun.tag = 8
        btn_Mon.tag = 9
        btn_Tue.tag = 10
        btn_Wed.tag = 11
        btn_Thu.tag = 12
        btn_Fri.tag = 13
        btn_Sat.tag = 14
        
        
        
    }
    
    // 액션 //
    // 사진 등록 버튼 
    @IBAction func btn_select_prdImage(_ sender: UIButton) {
        let imageRoutCheckAlert =  UIAlertController(title: "이미지 가져오기", message: "이미지를 가져올 방식을 선택하세요", preferredStyle: .actionSheet)
        let libraryAction =  UIAlertAction(title: "앨범", style: .default, handler: { ACTION in
            if(UIImagePickerController .isSourceTypeAvailable(.photoLibrary)){
                self.imagePickerController.sourceType = .photoLibrary
                self.present(self.imagePickerController, animated: false, completion: nil)
            } else {
                print("Camera not available")
            }
        })
        
        let cameraAction =  UIAlertAction(title: "카메라", style: .default, handler: { ACTION in
            if(UIImagePickerController .isSourceTypeAvailable(.camera)){
                self.imagePickerController.sourceType = .camera
                self.present(self.imagePickerController, animated: false, completion: nil)
            } else {
                print("Camera not available")
            }
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        imageRoutCheckAlert.addAction(libraryAction)
        imageRoutCheckAlert.addAction(cameraAction)
        imageRoutCheckAlert.addAction(cancelAction)
        present(imageRoutCheckAlert, animated: true, completion: nil)
    
    }
    
    
    var countCategory = 0
    var preSelectedForCategory = 0
    @IBAction func btn_select_category(_ sender: UIButton) {
        let num = sender.tag // 위에 태그 번호매긴거
        let index = sender.tag - 1 // 배열 인덱스
        print("\(num) && \(index)")
        
        // 하나만 활성화 시키기
        if countCategory == 0 {
            let CategoryBtn = self.view.viewWithTag(num) as! UIButton
            CategoryBtn.setImage(imgChecked, for: UIControl.State.normal)
            countCategory += 1
            preSelectedForCategory = num
            // 추가로 어레이 값 바꿔줌
            cgSeqnoChecked[index] = 1
             
        } else {
            let preCategoryBtn = self.view.viewWithTag(preSelectedForCategory) as! UIButton
            let CategoryBtn = self.view.viewWithTag(num) as! UIButton
            preCategoryBtn.setImage(imgUnchecked, for: UIControl.State.normal)
            CategoryBtn.setImage(imgChecked, for: UIControl.State.normal)
         
            // 추가로 어레이 값 바꿔줌   (이전에 선택된건 -> 0 으로, 방금 선택된건 ->1 로
            cgSeqnoChecked = [0,0,0,0,0]
            cgSeqnoChecked[index] = 1
            preSelectedForCategory = num
        }
        
    }
    
    var count = 0
    var preSelectedForTerm = 0

    @IBAction func btn_select_term(_ sender: UIButton) {
        let num = sender.tag
           let index = sender.tag - 6
           print("\(num) && \(index)")
           
           if count == 0 {
               let termBtn = self.view.viewWithTag(num) as! UIButton
               termBtn.setImage(imgChecked, for: UIControl.State.normal)
               count += 1
               preSelectedForTerm = num
               // 추가로 어레이 값 바꿔줌
                termChecked[index] = 1
                
           } else {
               let pretermBtn = self.view.viewWithTag(preSelectedForTerm) as! UIButton
               let termBtn = self.view.viewWithTag(num) as! UIButton
               pretermBtn.setImage(imgUnchecked, for: UIControl.State.normal)
               termBtn.setImage(imgChecked, for: UIControl.State.normal)
            
               // 추가로 어레이 값 바꿔줌   (이전에 선택된건 -> 0 으로, 방금 선택된건 ->1 로
            termChecked = [0,0]
            termChecked[index] = 1
               preSelectedForTerm = num
           }
    }
    
    @IBAction func btn_select_releaseDay(_ sender: UIButton) {
        let num = sender.tag
        let index = sender.tag - 8
        print("\(num) && \(index)")
        if releaseDayChecked[index] == 0 {
            releaseDayChecked[index] = 1
            let rDayBtn = self.view.viewWithTag(num) as! UIButton
            rDayBtn.setImage(imgChecked, for: UIControl.State.normal)
        } else {
            releaseDayChecked[index] = 0
            let rDayBtn = self.view.viewWithTag(num) as! UIButton
            rDayBtn.setImage(imgUnchecked, for: UIControl.State.normal)
        }
    }
    
    
    
    @IBAction func btn_AddProduct(_ sender: UIButton) {
        
        var checkResult = false
        checkResult = Check(tf_prdTitle.text!, tf_prdPrice.text!, tv_prdContext.text!)
        
        if checkResult {
            let storageRef = storage.reference()
            // File located on disk
            let localFile = imageURL
            //이미지 이름을 위한 dataformat
            
            if !imageName.isEmpty {
                let now = NSDate()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMddHHmmssEEE"
                let dateNow = dateFormatter.string(from: now as Date)
                
                imageName = dateNow + imageName
                print(imageName)
                
                // Create a reference to the file you want to upload
                let fileRef = storageRef.child("uImage/" + imageName)
                fileRef.putFile(from: localFile!, metadata: nil)
                //********************* 이미지 등록 완료
            }
            
            //체크버튼 String으로 변환//
            var resultCgSeqno = ""
            var resultTerm = ""
            var resultReleaseDay = ""
        
            var countCgSeqno = 0
            var countTerm = 0
            var countReleaseDay = 0
            let cgSeqno = ["1","2","3","4","5"]
            let term = ["매일", "매주"]
            let releaseDay = ["일","월","화","수","목","금","토"]

            //term
            for i in 0..<cgSeqnoChecked.count {
                if (cgSeqnoChecked[i] == 1 && countCgSeqno == 0) {
                    resultCgSeqno = cgSeqno[i]
                    countCgSeqno = 1
                } else if (cgSeqnoChecked[i] == 1 && countCgSeqno == 1) {
                    resultCgSeqno = cgSeqno[i]
                }
                //print(resultCgSeqno)
            }
            
            //term
            for i in 0..<termChecked.count {
                if (termChecked[i] == 1 && countTerm == 0) {
                    resultTerm = term[i]
                    countTerm = 1
                } else if (termChecked[i] == 1 && countTerm == 1) {
                    resultTerm = term[i]
                }
                //print(resultTerm)
            }
            
            //releaseDay
            for j in 0..<releaseDayChecked.count {
                if (releaseDayChecked[j] == 1 && countReleaseDay == 0) {
                    resultReleaseDay = releaseDay[j]
                    countReleaseDay = 1
                } else if (releaseDayChecked[j] == 1 && countReleaseDay == 1) {
                    resultReleaseDay = resultReleaseDay + "," + releaseDay[j]
                }
                //print(resultReleaseDay)
            }
            
            //print(resultTerm)
            let insertModel = MyChannelInsertUpdateDeleteModel() // 인스턴스 생성
            insertModel.InsertItems(term: resultTerm, releaseDay: resultReleaseDay, prdTitle: tf_prdTitle.text!, prdPrice: tf_prdPrice.text!, prdContext: tv_prdContext.text!, prdImage: imageName, chSeqno: receive_chSeqno, cgSeqno: receive_chSeqno)
        }
        myAlert(alertTitle: "확인", alertMessage: "등록되었습니다.", actionTitle: "OK", handler: {ACTION in
            self.navigationController?.popViewController(animated: true)
        })
        
       
    }
    
    
    // 함수 //
    func AddReceiveItems(chSeqno: String){
        receive_chSeqno = chSeqno
    }
    
    // 체크알럿
    func Check(_ prdTitle:String, _ prdPrice:String,_ prdContext:String) -> Bool{
        var result = false
        if prdTitle.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "상품명을 입력해주세요", actionTitle: "OK", handler: nil)
        } else if prdPrice.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "월별 가격을 입력해주세요", actionTitle: "OK", handler: nil)
        } else if prdContext.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "상품내용을 입력해주세요", actionTitle: "OK", handler: nil)
        } else if (termChecked[0] + termChecked[1] == 0) {
            myAlert(alertTitle: "확인", alertMessage: "콘텐츠 업로드 주기를 선택해주세요.", actionTitle: "OK", handler: nil)
        } else if (releaseDayChecked[0] + releaseDayChecked[1] + releaseDayChecked[2] + releaseDayChecked[3] + releaseDayChecked[4] + releaseDayChecked[5] + releaseDayChecked[6] == 0) {
            myAlert(alertTitle: "확인", alertMessage: "콘텐츠 업로드 요일을 선택해주세요.", actionTitle: "OK", handler: nil)
        } else {
            result = true
        }
        return result
    }
    
    func myAlert(alertTitle: String, alertMessage: String, actionTitle: String, handler:((UIAlertAction) -> Void)?) {
        let resultAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: handler)
        resultAlert.addAction(onAction)
        present(resultAlert, animated: true, completion: nil)
    }
    
    // 이미지
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            iv_addPrdImage.image = image
        }
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            imageURL = url
            imageName = url.lastPathComponent
        }
        
        // 켜놓은 앨범 화면 없애기
        dismiss(animated: true, completion: nil)
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
