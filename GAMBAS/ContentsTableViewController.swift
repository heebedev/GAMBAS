//
//  ContentsTableViewController.swift
//  GAMBAS
//
//  Created by Songhee Choi on 2020/09/17.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class ContentsTableViewController: UITableViewController, ContentsListQueryModelProtocol {
    
    // 연결 //
    @IBOutlet var contentsListTableView: UITableView!
    
    // 변수 //
    // 받은 변수
    var contentsListFeedItem: NSArray = NSArray()
    var receive_prdSeqno = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate 처리
        self.contentsListTableView.delegate = self
        self.contentsListTableView.dataSource = self
        
        let contentsListQueryModel = ContentsListQueryModel()
        contentsListQueryModel.delegate = self
        contentsListQueryModel.contentsListdownloadItems(prdSeqno: receive_prdSeqno)
    }
    
    // 프로토콜로부터 받은 item
    func contentsListItemDownloaded(items: NSArray) {
        contentsListFeedItem = items
        self.contentsListTableView.reloadData()
    }
   
    // table 뷰에서 함수 이름으로 데이터를 넘겨 줄 것임. 여기서 함수 이름 정의 먼저하고 -> table뷰로 이동!
    func subsInfoReceiveItems(_ prdSeqno:String){
         receive_prdSeqno = prdSeqno
       
    }
    
    
    
    // DB에서 다시 읽어 들이기
    override func viewWillAppear(_ animated: Bool) {
       let contentsListQueryModel = ContentsListQueryModel()
               contentsListQueryModel.delegate = self
               contentsListQueryModel.contentsListdownloadItems(prdSeqno: receive_prdSeqno)
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contentsListFeedItem.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentsListCell", for: indexPath) as! ContentsListTableViewCell

        // Configure the cell...
        let item: SubscribeDBModel = contentsListFeedItem[indexPath.row] as! SubscribeDBModel // DB 모델타입으로 바꾸고, data 뽑아 쓸 수 있음

        //text
        cell.lbl_ctTitle?.text = "\(item.ctTitle!)"
        
        // 날짜만 자르기 
        let formatReleaseDate = "\(item.ctReleaseDate!)"
        let endIdx: String.Index = formatReleaseDate.index(formatReleaseDate.startIndex, offsetBy: 10)

        let result = String(formatReleaseDate[...endIdx])
        cell.lbl_ctReleaseDate?.text = result

        return cell
    }
    
   
    
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
            let indexPath = self.contentsListTableView.indexPath(for: cell) // 몇 번쨰 클릭?

            let contentsListView = segue.destination as! ContentsViewController // 뷰컨트롤러 목적지
            let item: SubscribeDBModel = contentsListFeedItem[(indexPath! as NSIndexPath).row] as! SubscribeDBModel // 받은 내용 몇번째인지 확인하고 DBModel로 변환한 후
            
            // 필요한정보 빼와서
            let prdSeqno = String(item.ctSeqno!)
            
            
            // ctSeqno 보내줌
            // contentsListView.contentsInfoReceiveItems(ctSeqno) // 펑션만들기
            
        }
        
    }
    
}
    


// table view cell
class ContentsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_ctTitle: UILabel!
    @IBOutlet weak var lbl_ctReleaseDate: UILabel!
    
}

