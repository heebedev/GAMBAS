//
//  SecondViewController.swift
//  
//
//  Created by Aaqib Hussain on 03/08/2015.
//  Copyright (c) 2015 Kode Snippets. All rights reserved.
//

import UIKit
import Firebase

class SecondViewController: UIViewController, prdDetailQueryModelProtocol {
    
    var feedItem: NSArray = NSArray()
    
    @IBOutlet weak var ivChImage: UIImageView!
    @IBOutlet weak var lblChNickName: UILabel!
    @IBOutlet weak var lblChGrade: UILabel!
    @IBOutlet weak var tvPrdContext: UITextView!
    @IBOutlet weak var ivScImage: UIImageView!
    @IBOutlet weak var lblScTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uSeq = UserDefaults.standard.integer(forKey: "uSeqno")
        let prdSeq = UserDefaults.standard.integer(forKey: "prdSeqno")
        
        let queryModel = prdDetailQueryModel()
        queryModel.delegate = self
        queryModel.downloadItems(prdSeqno: String(prdSeq), uSeqno: String(uSeq))
        // Do any additional setup after loading the view.
    }
    
    func itemDownloaded(items: NSArray) {
        feedItem = items
        let item: prdDetailDBModel = feedItem[0] as! prdDetailDBModel // 배열로 되어있는 것을 class(DBModel) 타입으로 바꾼다.
        lblChNickName.text = (item.chNickName!)
        lblChGrade.text = (item.chGrade!)
        tvPrdContext.text = (item.prdContext!)
        lblScTitle.text = (item.sctTitle!)
        
        //Firebase image download
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imgRef = storageRef.child("chImage").child(item.chImage!)
        
        imgRef.getData(maxSize: 1 * 1024 * 1024) {data, error in
            if error != nil {
                self.ivChImage.image = UIImage(named: "emptyImage.png")
            } else {
                self.ivChImage.image = UIImage(data: data!)
            }
        }
        
        self.ivChImage.layer.cornerRadius = 50
        
        let spImgRef = storageRef.child("spContents").child(item.sctImage!)
        
        spImgRef.getData(maxSize: 1 * 1024 * 1024) {data, error in
            if error != nil {
                
            } else {
                self.ivScImage.image = UIImage(data: data!)
            }
        }
        
        self.ivScImage.layer.cornerRadius = 130/2
        
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
