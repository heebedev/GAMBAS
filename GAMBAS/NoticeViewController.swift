//
//  NoticeViewController.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/09/17.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NoticeListQueryModelProtocol {
    
    
    @IBOutlet weak var tvNoticeList: UITableView!
    
    let uSeqno = String(UserDefaults.standard.integer(forKey: "uSeqno"))
    var uName:String = ""
    var feedItem: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tvNoticeList.delegate = self
        tvNoticeList.dataSource = self
        tvNoticeList.rowHeight = 64
        
        tvNoticeList.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let queryModel = NoticeListQueryModel()
        queryModel.delegate = self
        queryModel.getUserName(userSeqno: uSeqno)
        queryModel.downloadItems(userSeqno: uSeqno)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tvNoticeList.reloadData()
    }
    
    func userNameDownloaded(uName: String) {
        self.uName = uName
    }
    
    func listItemDownloaded(items: NSArray) {
        feedItem = items
        self.tvNoticeList?.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItem.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeListCell", for: indexPath) as! NoticeTableViewCell
        let item: NoticeListModel = feedItem[indexPath.row] as! NoticeListModel
        if item.nName == uName {
            switch item.nCode {
            case "like":
                cell.ivNoticeImage.image = UIImage(named: "speaking_blue.png")
                cell.lbNoticeLabel.text = "\(item.nName!) 님이 \(item.nDetailName!)을 좋아합니다!"
                break
            case "subs":
                cell.ivNoticeImage.image = UIImage(named: "speaking_green.png")
                cell.lbNoticeLabel.text = "\(item.nName!) 님이 \(item.nDetailName!)을 구독하셨어요!"
                break
            case "review":
                cell.ivNoticeImage.image = UIImage(named: "speaking_pink.png")
                cell.lbNoticeLabel.text = "\(item.nName!) 님이 \(item.nDetailName!)에 후기를 남겼어요!"
                break
            default:
                break
            }
        } else {
            switch item.nCode {
            case "like":
                cell.ivNoticeImage.image = UIImage(named: "speaking_blue.png")
                cell.lbNoticeLabel.text = "\(item.nDetailName!)을 좋아합니다!"
                break
            case "subs":
                cell.ivNoticeImage.image = UIImage(named: "speaking_green.png")
                cell.lbNoticeLabel.text = "\(item.nDetailName!)을 구독하셨어요!"
                break
            case "review":
                cell.ivNoticeImage.image = UIImage(named: "speaking_pink.png")
                cell.lbNoticeLabel.text = "\(item.nDetailName!)에 후기를 남겼어요!"
                break
            default:
                break
            }
        }
        
        return cell
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
