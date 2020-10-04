//
//  MyChannelViewController.swift
//  GAMBAS
//
//  Created by Songhee Choi on 2020/10/04.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import Firebase



class MyChannelViewController: UIViewController, MyChannelSelectProtocol,UITableViewDataSource, UITableViewDelegate, MyProductSelectProtocol{
    
    
    
    
    
    // 아웃렛 연결 //
    // 내 채널 
    @IBOutlet weak var iv_chImage: UIImageView!
    @IBOutlet weak var lbl_chNickname: UILabel!
    @IBOutlet weak var lbl_chRegistDate: UILabel!
    @IBOutlet weak var lbl_chValidation: UILabel!
    @IBOutlet weak var lbl_chContext: UILabel!
    
    // 상품리스트 테이블
    @IBOutlet weak var tableview_productlist: UITableView!
    
    // 변수 //
    var feedItemMychannelInfo :NSArray = NSArray()
    var feedItemMyProductList :NSArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        uSeqno = String(UserDefaults.standard.integer(forKey: "uSeqno"))
        
        
        // 내 채널 정보 프로토콜 받을 작업
        let myChannelQueryModel = MyChannelSelect()
        myChannelQueryModel.delegate = self
        myChannelQueryModel.downloadItem_myChannel(userSeqno: uSeqno!)
        
        
        self.tableview_productlist.rowHeight = 140
        // product 테이블뷰 delegate 처리
        self.tableview_productlist.delegate = self
        self.tableview_productlist.dataSource = self
        self.tableview_productlist.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        // 프로덕트 리스트 받을라공
        let myChannelProductListQueryModel = MyProductSelect()
        myChannelProductListQueryModel.delegate = self
        myChannelProductListQueryModel.downloadItem_myProduct(uSeqno: uSeqno!)
        
      
        
    }
    
    
    

    func itemDownload_myChannel(itemChannel: NSArray) {
        feedItemMychannelInfo = itemChannel
        let itemMychannelInfo: MyChannelModel = feedItemMychannelInfo[0] as! MyChannelModel
       
        
        // set
        lbl_chNickname.text = itemMychannelInfo.chNickname
        
        // 날짜+시간만 자르기
        let formatReleaseDate = "\(itemMychannelInfo.chRegistDate!)"
        let endIdx: String.Index = formatReleaseDate.index(formatReleaseDate.startIndex, offsetBy: 10)
        
        let result = String(formatReleaseDate[...endIdx])
        lbl_chRegistDate.text = result
        
        // 폐쇄 여부 확인
        if itemMychannelInfo.chValidation == "0" {
            lbl_chValidation.text = "폐쇄중"
            lbl_chValidation.textColor = UIColor.red
        }else {
            lbl_chValidation.text = "운영중"
        }
        lbl_chContext.text = itemMychannelInfo.chContext
        
        //Firebase image download
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imgRef = storageRef.child("chImage").child(itemMychannelInfo.chImage!)
        print("Subs Table View \(itemMychannelInfo.chImage!)")
        
        imgRef.getData(maxSize: 1 * 1024 * 1024) {data, error in
            if error != nil {
                self.iv_chImage?.image = UIImage(named: "emptyImage.png")
            } else {
                self.iv_chImage?.image = UIImage(data: data!)
            }
        }
    }
    
    
    
    func itemDownload_myProduct(itemProduct: NSArray) {
        feedItemMyProductList = itemProduct
        self.tableview_productlist.reloadData()
    }
    
    // DB에서 다시 읽어 들이기
    override func viewWillAppear(_ animated: Bool) {
        let myChannelProductListQueryModel = MyProductSelect()
        myChannelProductListQueryModel.delegate = self
        myChannelProductListQueryModel.downloadItem_myProduct(uSeqno: uSeqno!)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedItemMyProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myChannelProductCell", for: indexPath) as! MyChannelProductTableViewCell
        
        // Configure the cell...
        let item: MyProductModel = feedItemMyProductList[indexPath.row] as! MyProductModel
        
        //text
        cell.lbl_prdTitle?.text = "\(item.prdTitle!)"
        cell.lbl_prdPrice?.text = "\(item.prdPrice!)"
        cell.lbl_term?.text = "\(item.term!)"
        cell.lbl_releaseDay?.text = "\(item.releaseDay!)"
        
        //Firebase image download
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imgRef = storageRef.child("prdImage").child(item.prdImage!)
        print("Subs Table View \(item.prdImage!)")
        
        imgRef.getData(maxSize: 1 * 1024 * 1024) {data, error in
            if error != nil {
                cell.iv_prdImage?.image = UIImage(named: "emptyImage.png")
            } else {
                cell.iv_prdImage?.image = UIImage(data: data!)
            }
        }
        cell.iv_prdImage.layer.cornerRadius = 97/2
        
        
        return cell
    }
    
    
    // 액션 //
    
    
    @IBAction func bbtnitem_back(_ sender: UIBarButtonItem) {
        // 네비게이션 컨트롤러 제거 
        self.navigationController?.popViewController(animated: true) }
    
    
    @IBAction func btn_manage_channel(_ sender: UIButton) {
    }
    
    @IBAction func btn_add_product(_ sender: UIButton) {
    }
    
    
    
    
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "sgChannelAddProduct"{
            let addProductView = segue.destination as! MyChannelAddProductViewController // 뷰컨트롤러 목적지
            let itemMychannelInfo: MyChannelModel = feedItemMychannelInfo[0] as! MyChannelModel // 받은 내용 DBModel로 변환한 후
            
            // 하나씩 빼와서
            let chSeqno = itemMychannelInfo.chSeqno!
            //let cgSeqno = itemMychannelInfo.cgSeqno!
            print(itemMychannelInfo.chSeqno!)
            //print(itemMychannelInfo.cgSeqno!)
            
            
            // prdSeqno 보내줌
            addProductView.AddReceiveItems(chSeqno: chSeqno) // 펑션만들기
            
        } // 콘텐츠 리스트에 넘겨주기
        else if segue.identifier == "sgChannelContentsList"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tableview_productlist.indexPath(for: cell) // 몇 번쨰 클릭?
            
            let myProductView = segue.destination as! MyProductViewController // 뷰컨트롤러 목적지
            
            let item: MyProductModel = feedItemMyProductList[(indexPath! as NSIndexPath).row] as! MyProductModel // 받은 내용 몇번째인지 확인하고 DBModel로 변환한 후
            
            // 하나씩 빼와서
            let prdSeqno = String(item.prdSeqno!)
            let term = String(item.term!)
            let releaseDay = String(item.releaseDay!)
            let prdTitle = String(item.prdTitle!)
            let prdPrice = String(item.prdPrice!)
            let prdContext = String(item.prdContext!)
            let prdImage = String(item.prdImage!)
            let prdRegistDate = String(item.prdRegistDate!)
            let prdValidation = String(item.prdValidation!)
            let chSeqno = String(item.chSeqno!)
            let cgSeqno = String(item.cgSeqno!)
            
            // 넣어줌
            myProductView.receiveItemsSelectedProduct(prdSeqno, term, releaseDay, prdTitle, prdPrice, prdContext, prdImage, prdRegistDate, prdValidation, chSeqno, cgSeqno)
            
        }
        
    }
  
    
    
    
    

}


// table view cell
class MyChannelProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iv_prdImage: UIImageView!
    
    @IBOutlet weak var lbl_prdTitle: UILabel!
    @IBOutlet weak var lbl_prdPrice: UILabel!
    @IBOutlet weak var lbl_term: UILabel!
    @IBOutlet weak var lbl_releaseDay: UILabel!
    
}
