//
//  SignUpViewController.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/09/28.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, EmailChkModelProtocol, SignupInsertDBModelProtocol {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var rpwTextField: UITextField!
    @IBOutlet weak var BirthTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var ivUserProfileImage: UIImageView!
    @IBOutlet weak var btnCheckCGText: UIButton!
    @IBOutlet weak var btnCheckCGPicture: UIButton!
    @IBOutlet weak var btnCheckCGVideo: UIButton!
    @IBOutlet weak var btnCheckCGMusic: UIButton!
    
    
    let imagePickerController = UIImagePickerController()
    var imageURL: URL?
    var imageName: String = ""
    var emailCheckResult: Int = 1
    var categoryChecked = [0,0,0,0]
    
    let imgUnchecked = UIImage(named: "unchecked.png")
    let imgChecked = UIImage(named: "checked.png")
    
    let storage = Storage.storage()
    let emailchk = EmailChkModel()
    let insertdbModel = SigupInsertDBModel()
   
    
    // --------------------------------- PROTOCOL -----------------------------
    func signupResultDownloaded(result: Bool) { //-----------------------------
        if result {
            print("protocol 돌아옴 \(result)")
            let resultAlert = UIAlertController(title: "완료", message: "회원가입에 성공했습니다.", preferredStyle: UIAlertController.Style.alert)
            let  onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {Action in
                // 전화면으로 넘어가기위한것
                self.dismiss(animated: true, completion: nil)
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        } else {
            myAlert(alertTitle: "회원가입 실패", alertMessage: "다시 확인해주세요.", actionTitle: "OK", handler: nil)
        }
    }
    
    func itemDownloaded(item: Int) {
        emailCheckResult = item
        
        if emailCheckResult == 0 {
            myAlert(alertTitle: "확인", alertMessage: "사용가능한 이메일입니다.", actionTitle: "OK", handler: nil)
            pwTextField.isEnabled = true
            rpwTextField.isEnabled = true
            NameTextField.isEnabled = true
            BirthTextField.isEnabled = true
            PhoneTextField.isEnabled = true
        } else {
            myAlert(alertTitle: "이메일 중복", alertMessage: "이미 사용중인 이메일입니다.", actionTitle: "OK", handler: nil)
        }
    }
    
    // --------------------------------- Start -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePickerController.delegate = self
        
        pwTextField.isEnabled = false
        rpwTextField.isEnabled = false
        NameTextField.isEnabled = false
        BirthTextField.isEnabled = false
        PhoneTextField.isEnabled = false
        
        ivUserProfileImage.image = UIImage(named: "emptyImage.png")
        self.ivUserProfileImage.layer.cornerRadius = 75
        
        btnCheckCGText.tag = 1
        btnCheckCGPicture.tag = 2
        btnCheckCGVideo.tag = 3
        btnCheckCGMusic.tag = 4
        
        
        emailchk.delegate = self
        insertdbModel.delegate = self
        
        
    }
    
    // --------------------------------- 사진 등록 버튼  -----------------------------
    @IBAction func btnAddPhoto(_ sender: Any) {
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
    
    
    // --------------------------------- 이메일 중복확인 -----------------------------
    @IBAction func btnEmail(_ sender: UIButton) {
        let email = idTextField.text!
        
        if isValidEmail(emailStr: email){
            
            emailchk.EmailChkloadItems(uEmail: email)
            
        } else {
            myAlert(alertTitle: "오류", alertMessage: "이메일 형식으로 입력해주세요.", actionTitle: "OK", handler: nil)
        }
    }
    
    
    
    // DB 입력 버튼
    @IBAction func btnAdd(_ sender: UIButton) {
        let email = idTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: "")
        let password = pwTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: "")
        let rPassword = rpwTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: "")
        let birth = BirthTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: "")
        let name = NameTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: "")
        let phone = PhoneTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: "")
        
        var checkResult = false
        
        if email.isEmpty {
            myAlert(alertTitle: "실패", alertMessage: "이메일을 입력해주세요.", actionTitle: "OK", handler: nil)
        } else if !isValidEmail(emailStr: email) {
            myAlert(alertTitle: "실패", alertMessage: "이메일 형식으로 입력해주세요.", actionTitle: "OK", handler: nil)
        } else if emailCheckResult == 1 {
            myAlert(alertTitle: "실패", alertMessage: "이메일 중복확인을 해주세요.", actionTitle: "OK", handler: nil)
        } else {
            print("\(email), \(password), \(rPassword), \(birth), \(name), \(phone)")
            checkResult = Check(password, rPassword, name, birth, phone)
        }
        
        
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
            
            //카테고리 구성
            var result = ""
            var count = 0
            let category = ["글", "그림", "영상", "음악"]
            for i in 0..<categoryChecked.count {
                if (categoryChecked[i] == 1 && count == 0) {
                    result = category[i]
                    count = 1
                } else if (categoryChecked[i] == 1 && count == 1) {
                    result = result + "," + category[i]
                }
                print(result)
            }
            print(result)
            
            insertdbModel.signUpInsertloadItems(Email: email, Password: password, Name: name, Birth: birth, Phone: phone, Image: imageName, interestCategory: result)
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ivUserProfileImage.image = image
        }
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            imageURL = url
            imageName = url.lastPathComponent
        }
        
        // 켜놓은 앨범 화면 없애기
        dismiss(animated: true, completion: nil)
    }
    
    func Check(_ password:String, _ chkPassword:String,_ name:String, _ birth:String, _ phone:String) -> Bool{
        var result = false
        if password.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "비밀번호를 입력해주세요", actionTitle: "OK", handler: nil)
        } else if chkPassword.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "비밀번호를 재확인해주세요", actionTitle: "OK", handler: nil)
        } else if password != chkPassword {
            myAlert(alertTitle: "확인", alertMessage: "비밀번호가 서로 다릅니다.", actionTitle: "OK", handler: nil)
        } else if name.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "이름을 입력해주세요", actionTitle: "OK", handler: nil)
        } else if birth.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "생일을 입력해주세요", actionTitle: "OK", handler: nil)
        } else if phone.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "전화번호를 입력해주세요", actionTitle: "OK", handler: nil)
        } else if (categoryChecked[0] + categoryChecked[1] + categoryChecked[2] + categoryChecked[3] == 0) {
            myAlert(alertTitle: "확인", alertMessage: "선호하시는 카테고리를 선택해주세요.", actionTitle: "OK", handler: nil)
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
    
    // 이메일
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    
    
    // 패스워드
    func validatePassword(password:String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,24}$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
    
    
    @IBAction func btnCategorySelect(_ sender: UIButton) {
        let num = sender.tag
        let index = sender.tag - 1
        print("\(num) && \(index)")
        if categoryChecked[index] == 0 {
            categoryChecked[index] = 1
            let cgBtn = self.view.viewWithTag(num) as! UIButton
            cgBtn.setImage(imgChecked, for: UIControl.State.normal)
        } else {
            categoryChecked[index] = 0
            let cgBtn = self.view.viewWithTag(num) as! UIButton
            cgBtn.setImage(imgUnchecked, for: UIControl.State.normal)
        }
    }
    
    
}
