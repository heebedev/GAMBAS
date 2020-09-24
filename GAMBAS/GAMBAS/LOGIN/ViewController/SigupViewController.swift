//
//  SigupViewController.swift
//  GAMBAS
//
//  Created by TJ on 21/09/2020.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class SigupViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate, EmailChkModelProtocol {

       @IBOutlet weak var idTextField: UITextField!
       @IBOutlet weak var pwTextField: UITextField!
       @IBOutlet weak var rpwTextField: UITextField!
       @IBOutlet weak var BirthTextField: UITextField!
       @IBOutlet weak var NameTextField: UITextField!
       @IBOutlet weak var PhoneTextField: UITextField!
       @IBOutlet weak var CatrgoyTextField: UITextField!
       
       @IBOutlet weak var Image: UIImageView!
        
       let imagePickerController = UIImagePickerController()
       var imageURL: URL?
       var emailCheckResult: Int = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePickerController.delegate = self
        
        pwTextField.isEnabled = false
        rpwTextField.isEnabled = false
        NameTextField.isEnabled = false
        BirthTextField.isEnabled = false
        PhoneTextField.isEnabled = false
        CatrgoyTextField.isEnabled = false

    }
    
    // 사진 DB 입력
        @IBAction func btnPhoto(_ sender: UIBarButtonItem) {
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
        // 아이디 중복확인
        @IBAction func btnEmail(_ sender: UIButton) {
            let email = idTextField.text!
            
            if isValidEmail(emailStr: email){
                let emailchk = EmailChkModel()
                    emailchk.delegate = self
                    emailchk.EmailChkloadItems(uEmail: email)
                    
                }else{
                    myAlert(alertTitle: "오류", alertMessage: "이메일 형식으로 입력해주세요.", actionTitle: "OK", handler: nil)
                }
        }
    
    func itemDownloaded(item: Int) {
          emailCheckResult = item
          
          if emailCheckResult == 0 {
              print("emailCheckResult \(emailCheckResult)")
              myAlert(alertTitle: "확인", alertMessage: "사용가능한 이메일입니다.", actionTitle: "OK", handler: nil)
              pwTextField.isEnabled = true
              rpwTextField.isEnabled = true
              NameTextField.isEnabled = true
              BirthTextField.isEnabled = true
              PhoneTextField.isEnabled = true
            CatrgoyTextField.isEnabled = true
          } else {
              print("emailCheckResult \(emailCheckResult)")
              myAlert(alertTitle: "이메일 중복", alertMessage: "이미 사용중인 이메일입니다.", actionTitle: "OK", handler: nil)
          }
      }
    
        // DB 입력 버튼
        @IBAction func btnAdd(_ sender: UIButton) {
            let Email = idTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: " ")
            let Password = pwTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: " ")
            let rPassword = rpwTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: " ")
            let Birth = BirthTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: " ")
            let Name = NameTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: " ")
            let Phone = PhoneTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: " ")
            let interestCategory = CatrgoyTextField.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: " ")
            
            if Email.isEmpty {
                       myAlert(alertTitle: "실패", alertMessage: "이메일을 입력해주세요.", actionTitle: "OK", handler: nil)
                   } else if !isValidEmail(emailStr: Email) {
                       myAlert(alertTitle: "실패", alertMessage: "이메일 형식으로 입력해주세요.", actionTitle: "OK", handler: nil)
                   } else if emailCheckResult == 1 {
                       myAlert(alertTitle: "실패", alertMessage: "이메일 중복확인을 해주세요.", actionTitle: "OK", handler: nil)
                   } else {
                    Check(Password,Name, Birth, Phone, rPassword)
                   }

                   
                   if validatePassword(password: Password){
                       print("성공")
                   }else{
                       myAlert(alertTitle: "실패", alertMessage: "최소 8글자이상, 대문자, 소문자, 숫자 조합으로 입력해주새요.", actionTitle: "OK", handler: nil)
                       print("실패")
                   }

            
            if rpwTextField.text == pwTextField.text{
                let resultAlert = UIAlertController(title: "완료", message: "회원가입에 성공했습니다.", preferredStyle: UIAlertController.Style.alert)
                let  onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {Action in
                    // 전화면으로 넘어가기위한것
                    self.navigationController?.popViewController(animated: true)
                    
                    let insertdbModel = SigupInsertDBModel()
                    insertdbModel.uploadImageFile(at: self.imageURL!, Email: Email, Password: Password, Name: Name, Birth: Birth, Phone: Phone, interestCategory: interestCategory, completionHandler: {_,_ in})
                })
                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)
            }else {
                let resultAlert = UIAlertController(title: "실패", message: "비밀번호가 일치하지 않습니다.", preferredStyle: UIAlertController.Style.alert)
                let  onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)
            }
    }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    Image.image = image
                    
                    imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
                }
                
                // 켜놓은 앨범 화면 없애기
                dismiss(animated: true, completion: nil)
            }
    
    func Check(_ password:String, _ chkPassword:String,_ name:String, _ birth:String, _ phone:String){
        if password.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "비밀번호를 입력해주세요", actionTitle: "OK", handler: nil)
        } else if chkPassword.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "비밀번호를 재확인해주세요", actionTitle: "OK", handler: nil)
        } else if name.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "이름을 입력해주세요", actionTitle: "OK", handler: nil)
        } else if birth.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "생일을 입력해주세요", actionTitle: "OK", handler: nil)
        } else if phone.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "전화번호를 입력해주세요", actionTitle: "OK", handler: nil)
        } else {

        }
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
        
    }// ---

