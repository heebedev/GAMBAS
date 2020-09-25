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
    
    var prdSeqno: Int?
    var chName: String?
    var chImage: String?
    var uSeqno: Int?
    
    @IBOutlet weak var tvReviewList: UITableView!
    @IBOutlet weak var btnAddReview: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvReviewList.delegate = self
        self.tvReviewList.dataSource = self
        self.tvReviewList.rowHeight = 80
        self.tvReviewList.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        uSeqno = UserDefaults.standard.integer(forKey: "uSeqno")
        prdSeqno = UserDefaults.standard.integer(forKey: "prdSeqno")
        
        let queryModel = prdReviewQueryModel()
        queryModel.delegate = self
        queryModel.downloadItems(prdSeqno: String(prdSeqno!), uSeqno: String(uSeqno!))
        
    }
    
    func receiveItems( _ prdSeq:String, _ chNickName:String, _ prdImage: String) {
        self.prdSeqno  = Int(prdSeq)
        self.chName = chNickName
        self.chImage = prdImage
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
    
    var scroll = 0
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isBouncingTop {
            if scroll == 0 {
            }
            scroll = 1
        } else if scrollView.isBouncingBottom {
            if scroll == 0 {
                let queryModel = prdReviewQueryModel()
                queryModel.delegate = self
                queryModel.downloadItems(prdSeqno: String(prdSeqno!), uSeqno: String(uSeqno!))
            }
            scroll = -1
        } else {
            scroll = 0
        }
    }
    
}

extension UIScrollView {
    var isBouncing: Bool {
        return isBouncingTop || isBouncingBottom
    }
    
    var isBouncingTop: Bool {
        return contentOffset.y < topInsetForBouncing - contentInset.top
    }
    
    var isBouncingBottom: Bool {
        let threshold: CGFloat
        if contentSize.height > frame.size.height {
            threshold = (contentSize.height - frame.size.height + contentInset.bottom + bottomInsetForBouncing)
        } else {
            threshold = topInsetForBouncing
        }
        return contentOffset.y > threshold
    }
    
    private var topInsetForBouncing: CGFloat {
        return safeAreaInsets.top != 0.0 ? -safeAreaInsets.top : 0.0
    }
    
    private var bottomInsetForBouncing: CGFloat {
        return safeAreaInsets.bottom
    }
}

