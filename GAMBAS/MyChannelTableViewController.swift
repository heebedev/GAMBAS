//
//  MyChannelTableViewController.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/17.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class MyChannelTableViewController: UITableViewController, MyChannelSelectProtocol, MyProductSelectProtocol, MyContentsSelectProtocol{

    @IBOutlet weak var ivLJHChannelImage: UIImageView!
    @IBOutlet weak var lblLJHChannelName: UILabel!
    @IBOutlet weak var lblLJHChannelContent: UILabel!
    @IBOutlet weak var lblLJHChannelRegisterDate: UILabel!
    
    @IBOutlet weak var ivLJHProductImage: UIImageView!
    @IBOutlet weak var lblLJHProductName: UILabel!
    @IBOutlet weak var lblLJHProductContent: UILabel!
    @IBOutlet weak var lblLJHProductCategory: UILabel!
    @IBOutlet weak var lblLJHProductRegisterDate: UILabel!
    @IBOutlet weak var lblLJHProductTerm: UILabel!
    @IBOutlet weak var lblLJHProductDay: UILabel!
    @IBOutlet weak var lblLJHProductPrice: UILabel!
    
    @IBOutlet var tvLJHContentsList: UITableView!
        
    var channelSeqno: String?
    var channelContent: String?
    var channelName: String?
    var channelImage: String?
    var channelRegisterDate: String?
    var channelValidation: String?
    
    var productSeqno: String?
    var ProductTerm: String?
    var ProductReleaseDay: String?
    var ProductTitle: String?
    var ProductPrice: String?
    var ProductContent: String?
    var productImage: String?
    var ProductRegisterDate: String?
    var ProductValidation: String?
    var ProductCategory: String?

    var feeditems_channel: NSArray = NSArray()
    var feeditems_product: NSArray = NSArray()
    var feeditems_contents: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tvLJHContentsList.delegate = self
        self.tvLJHContentsList.dataSource = self
        self.tvLJHContentsList.rowHeight = 124
        
        // 인스턴트 만들어서 구동시켜야지.
        let myChannelSelect = MyChannelSelect()
        myChannelSelect.delegate = self
        myChannelSelect.downloadItem_myChannel(userSeqno: "1") // 절대값***
        
        let myProductSelect = MyProductSelect()
        myProductSelect.delegate = self
        myProductSelect.downloadItem_myProduct(channelSeqno: "1") // 절대값***
        
        let myContentsSelect = MyContentsSelect()
        myContentsSelect.delegate = self
        myContentsSelect.downloadItem_myContents(productSeqno: "1") // 절대값***
        
        print("viewDidLoad()")
    }
    
    func itemDownload_myChannel(item: NSArray) {
        feeditems_channel = item
        let myChannel: MyChannelModel = feeditems_channel[0] as! MyChannelModel
        
        channelSeqno = myChannel.chSeqno
        channelContent = myChannel.chContext
        channelName = myChannel.chNickname
        channelImage =  myChannel.chImage
        channelRegisterDate = myChannel.chRegistDate
        channelValidation = myChannel.chValidation
    }
    
    func itemDownload_myProduct(item: NSArray) {
        feeditems_product = item
        let myProduct: MyProductModel = feeditems_product[0] as! MyProductModel
        
//        productSeqno = myProduct.prdSeqno
//        ProductTerm = myProduct.
//        ProductReleaseDay = myProduct.prdSeqno
//        ProductTitle = myProduct.prdSeqno
//        ProductPrice = myProduct.prdSeqno
//        ProductContent = myProduct.prdSeqno
//        productImage = myProduct.prdSeqno
//        ProductRegisterDate = myProduct.prdSeqno
//        ProductValidation = myProduct.prdSeqno
//        ProductCategory = myProduct.prdSeqno
    }
    
    func itemDownload_myContents(item: NSArray) {
        feeditems_contents = item
        self.tvLJHContentsList.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feeditems_contents.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyContentsListCell", for: indexPath) as! MyContentsListTableViewCell

        // Configure the cell...
        let contentsList: MyContentsModel = feeditems_contents[indexPath.row] as! MyContentsModel
        
//        cell.ivLJHContentsImage
        cell.lblLJHContentsTitle?.text = contentsList.ctTitle
        cell.lblLJHContentsRegisterDate?.text = contentsList.ctRegistDate
        cell.lblLJHContentsContent?.text = contentsList.ctContext

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
