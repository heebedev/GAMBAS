//
//  SecondViewController.swift
//  
//
//  Created by Aaqib Hussain on 03/08/2015.
//  Copyright (c) 2015 Kode Snippets. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, prdDetailQueryModelProtocol {
    
    var feedItem: NSArray = NSArray()
    
    @IBOutlet weak var ivChImage: UIImageView!
    @IBOutlet weak var lblChNickName: UILabel!
    @IBOutlet weak var lblChGrade: UILabel!
    @IBOutlet weak var tvPrdContext: UITextView!
    @IBOutlet weak var ivScImage: UIImageView!
    @IBOutlet weak var ivScImage2: UIImageView!
    @IBOutlet weak var lblScTitle: UILabel!
    @IBOutlet weak var lblScTitle2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queryModel = prdDetailQueryModel()
        queryModel.delegate = self
        queryModel.downloadItems(prdSeqno: "1", uSeqno: "1")
        // Do any additional setup after loading the view.
    }
    
    func itemDownloaded(items: NSArray) {
        feedItem = items
        let item: prdDetailDBModel = feedItem[0] as! prdDetailDBModel // 배열로 되어있는 것을 class(DBModel) 타입으로 바꾼다.
        lblChNickName.text = (item.chNickName!)
        lblChGrade.text = (item.chGrade!)
        tvPrdContext.text = (item.prdContext!)
        lblScTitle.text = (item.sctTitle!)

        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
