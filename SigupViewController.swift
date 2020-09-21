//
//  SigupViewController.swift
//  GAMBAS
//
//  Created by TJ on 21/09/2020.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class SigupViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePickerController.delegate = self
    }
    // 사진 DB 입력
        @IBAction func btnPhoto(_ sender: UIBarButtonItem) {
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
        // 아이디 중복확인
        @IBAction func btnEmail(_ sender: UIButton) {
           
        }
       
        
        
        
        
        
        
        
        
        
        
        // DB 입력 버튼
        @IBAction func btnAdd(_ sender: UIButton) {
            let Email = idTextField.text!
            let Password = pwTextField.text!
            let Birth = BirthTextField.text!
            let Name = NameTextField.text!
            let Phone = PhoneTextField.text!
            let interestCategory = CatrgoyTextField.text!
            
            let insertdbModel = SigupInsertDBModel()
            insertdbModel.uploadImageFile(at: imageURL!, Email: Email, Password: Password, Name: Name, Birth: Birth, Phone: Phone, interestCategory: interestCategory, completionHandler: {_,_ in})
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    Image.image = image
                    
                    imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
                }
                
                // 켜놓은 앨범 화면 없애기
                dismiss(animated: true, completion: nil)
            }
    }// ---

