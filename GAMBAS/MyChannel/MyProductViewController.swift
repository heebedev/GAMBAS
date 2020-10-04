//
//  MyProductViewController.swift
//  GAMBAS
//
//  Created by Songhee Choi on 2020/10/05.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import Firebase

class MyProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MyContentsSelectProtocol {
  
   
    // 아웃렛 연결 //
    // 내 게시물
    @IBOutlet weak var iv_prdImage: UIImageView!
    @IBOutlet weak var lbl_prdTitle: UILabel!
    @IBOutlet weak var lbl_prdPrice: UILabel!
    @IBOutlet weak var lbl_prdValidation: UILabel!
    @IBOutlet weak var lbl_term: UILabel!
    @IBOutlet weak var lbl_releaseDay: UILabel!
    @IBOutlet weak var lbl_prdContext: UILabel!
    
    
    // 콘텐츠 테이블
    @IBOutlet weak var tableview_contentslist: UITableView!
    
    
    // 변수 //
    var feedItemMyContentsList :NSArray = NSArray()

    // productDetails
    var receiveprdSeqno = ""
    var receiveterm = ""
    var receivereleaseDay = ""
    var receiveprdTitle = ""
    var receiveprdPrice = ""
    var receiveprdContext = ""
    var receiveprdImage = ""
    var receiveprdRegistDate = ""
    var receiveValidation = ""
    var receivechSeqno = ""
    var receivecgSeqno = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        uSeqno = String(UserDefaults.standard.integer(forKey: "uSeqno"))
        
        
        
        self.tableview_contentslist.rowHeight = 128
        // product 테이블뷰 delegate 처리
        self.tableview_contentslist.delegate = self
        self.tableview_contentslist.dataSource = self
        self.tableview_contentslist.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        // 콘텐츠 리스트 받기
        let myChannelContentsListQueryModel = MyContentsSelect()
        myChannelContentsListQueryModel.delegate = self
        myChannelContentsListQueryModel.downloadItem_myContents(productSeqno: receiveprdSeqno)
        
        
        // 받은거 바로 넣어버릴거야!!!!! //--------
        
        // set product
        lbl_prdTitle?.text = "\(receiveprdTitle)"
        lbl_prdPrice?.text = "\(receiveprdPrice)"
        lbl_term?.text = "\(receiveterm)"
        lbl_releaseDay?.text = "\(receivereleaseDay)"
        lbl_prdContext?.text = "\(receiveprdContext)"
        
        print( receiveValidation )
        
        
        // 폐쇄 여부 확인
        if receiveValidation == "0" {
            lbl_prdValidation!.text = "폐쇄중"
            lbl_prdValidation!.textColor = UIColor.red
        }else {
            lbl_prdValidation!.text = "운영중"
        }
        
        
        //Firebase image download
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imgRef = storageRef.child("chImage").child(receiveprdImage)
        print("Subs Table View \(receiveprdImage)")
        
        imgRef.getData(maxSize: 1 * 1024 * 1024) {data, error in
            if error != nil {
                self.iv_prdImage?.image = UIImage(named: "emptyImage.png")
            } else {
                self.iv_prdImage?.image = UIImage(data: data!)
            }
        }
        
        
    }

    func itemDownload_myContents(itemContents: NSArray) {
        feedItemMyContentsList = itemContents
        self.tableview_contentslist.reloadData()
    }
    
    // DB에서 다시 읽어 들이기
    override func viewWillAppear(_ animated: Bool) {
        let myChannelContentsListQueryModel = MyContentsSelect()
        myChannelContentsListQueryModel.delegate = self
        myChannelContentsListQueryModel.downloadItem_myContents(productSeqno: receiveprdSeqno)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedItemMyContentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myChannelContentsCell", for: indexPath) as! MyProductContentsTableViewCell
        
        // Configure the cell...
        let item: MyContentsModel = feedItemMyContentsList[indexPath.row] as! MyContentsModel
        
        //text
        cell.lbl_ctTitle?.text = "\(item.ctTitle!)"
        cell.lbl_ctContext?.text = "\(item.ctContext!)"
        cell.lbl_ctReleaseDate?.text = "\(item.ctReleaseDate!)"
        
        return cell
    }
    
    // prepare로 받은 Product Details
    func receiveItemsSelectedProduct(_ prdSeqno:String, _ term: String, _ releaseDay: String, _ prdTitle: String, _ prdPrice: String, _ prdContext: String, _ prdImage: String, _ prdRegistDate: String, _ prdValidation: String, _ chSeqno: String, _ cgSeqno: String){
        receiveprdSeqno = prdSeqno
        receiveterm = term
        receivereleaseDay = releaseDay
        receiveprdTitle = prdTitle
        receiveprdPrice = prdPrice
        receiveprdContext = prdContext
        receiveprdImage = prdImage
        receiveprdRegistDate = prdRegistDate
        receiveValidation = prdValidation
        receivechSeqno = chSeqno
        receivecgSeqno = cgSeqno
        
        
        
        
        
    
    
    }
  
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    

}//---


// table view cell
class MyProductContentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_ctTitle: UILabel!
    
    @IBOutlet weak var lbl_ctContext: UILabel!
    
    @IBOutlet weak var lbl_ctReleaseDate: UILabel!
}


