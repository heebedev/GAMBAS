//
//  SubscribeTableViewController.swift
//  GAMBAS
//
//  Created by Songhee Choi on 2020/09/17.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import Firebase

var uSeqno: String?  // test

class SubscribeTableViewController: UITableViewController, SubsListQueryModelProtocol {
    
    
    // 연결 //
    @IBOutlet var subsListTableView: UITableView!
    
    
    // 변수 //
    // 받은 변수
    var subsListFeedItem: NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subsListTableView.rowHeight = 119
        // static uSeqno
        uSeqno = String(UserDefaults.standard.integer(forKey: "uSeqno"))
                //print("static uSeqno테스트", uSeqno!)
                //uSeqno = "1" // test
                //print("uSeqno테스트", uSeqno!)
        
        //delegate 처리
        self.subsListTableView.delegate = self
        self.subsListTableView.dataSource = self
        self.subsListTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        let subsListQueryModel = SubsListQueryModel()
        subsListQueryModel.delegate = self
        subsListQueryModel.subsListdownloadItems(uSeqno: uSeqno!)
        
    }
    
    // 프로토콜로부터 받은 item
    func subsListItemDownloaded(items: NSArray) {
        subsListFeedItem = items
        self.subsListTableView.reloadData()
    }
    
    // DB에서 다시 읽어 들이기
    override func viewWillAppear(_ animated: Bool) {
        let subsListQueryModel = SubsListQueryModel()
        subsListQueryModel.delegate = self
        subsListQueryModel.subsListdownloadItems(uSeqno: uSeqno!)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subsListFeedItem.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subsListCell", for: indexPath) as! SubsListTableViewCell
        
        // Configure the cell...
        let item: SubscribeDBModel = subsListFeedItem[indexPath.row] as! SubscribeDBModel 
        
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
        
        cell.layer.cornerRadius = 50
        cell.layer.masksToBounds = true
        
        //text
        cell.lbl_prdTitle?.text = "\(item.prdTitle!)"
        cell.lbl_chNickname?.text = "\(item.chNickname!)"
        cell.lbl_term?.text = "\(item.term!)"
        cell.lbl_releaseDay?.text = "\(item.releaseDay!)"
        cell.lbl_cgName?.text = "\(item.cgName!)"
        
//        cell.layer.cornerRadius = 20
//        cell.layer.masksToBounds = true
//        cell.layer.borderWidth = 0.5
//        cell.layer.borderColor = UIColor.systemBlue.cgColor
        
        return cell
    }
    
//    // write 위치 (스마트폰의)
//    func getDecumentDirectory() -> URL{
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0] // 첫번째 값 앱에 설정한 것의 위치
//    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }    
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "sgContentsList"{
            let cell = sender as! UITableViewCell
            let indexPath = self.subsListTableView.indexPath(for: cell) // 몇 번쨰 클릭?
            
            let contentsListView = segue.destination as! ContentsTableViewController // 뷰컨트롤러 목적지
            let item: SubscribeDBModel = subsListFeedItem[(indexPath! as NSIndexPath).row] as! SubscribeDBModel // 받은 내용 몇번째인지 확인하고 DBModel로 변환한 후
            
            // 하나씩 빼와서
            let prdSeqno = String(item.prdSeqno!)
            
            
            // prdSeqno 보내줌
            contentsListView.subsInfoReceiveItems(prdSeqno) // 펑션만들기 
            
        }
        
    }
    
    
}

// table view cell 
class SubsListTableViewCell: UITableViewCell {
    @IBOutlet weak var iv_prdImage: UIImageView!
    @IBOutlet weak var lbl_prdTitle: UILabel!
    @IBOutlet weak var lbl_chNickname: UILabel!
    @IBOutlet weak var lbl_term: UILabel!
    @IBOutlet weak var lbl_releaseDay: UILabel!
    @IBOutlet weak var lbl_cgName: UILabel!
    
}
