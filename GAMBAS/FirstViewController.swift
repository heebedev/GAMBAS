//
//  FirstViewController.swift
//  
//
//  Created by Aaqib Hussain on 03/08/2015.
//  Copyright (c) 2015 Kode Snippets. All rights reserved.
//

import UIKit
import Firebase



class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, prdDetailQueryModelProtocol  {

    
    var feedItem: NSArray = NSArray()
    
    @IBOutlet weak var tvReviewList: UITableView!
    @IBOutlet weak var btnAddReview: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tvReviewList.delegate = self
        self.tvReviewList.dataSource = self
        self.tvReviewList.rowHeight = 115
        
        let queryModel = prdReviewQueryModel()
        queryModel.delegate = self
        queryModel.downloadItems(prdSeqno: "1", uSeqno: "2")
        
    }

    func itemDownloaded(items: NSArray) {
        feedItem = items
        self.tvReviewList.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! reviewTableViewCell
        // Configure the cell...

        let item: prdDetailDBModel = feedItem[indexPath.row] as! prdDetailDBModel // 배열로 되어있는 것을 class(DBModel) 타입으로 바꾼다.
        if(Int(item.uSeqCount!) == 0){
            btnAddReview.isHidden = true
        }
        
        cell.lblRTitle.text = (item.rTitle!)
        cell.lblUName.text = (item.uName!)
        cell.lblRGrade.text = (item.rGrade!)
        
        return cell
    }
   
     
}
