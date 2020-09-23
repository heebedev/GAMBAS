//
//  MyChannelTableViewController.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/17.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class MyChannelTableViewController: UITableViewController, MyChannelSelectProtocol, MyProductSelectProtocol, MyContentsSelectProtocol{
    
    @IBOutlet weak var MyContentsListSearchBar: UISearchBar!
    
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
    
    var uSeqno = ""
        
    var channelSeqno = ""
    var channelContent = ""
    var channelName = ""
    var channelImage = ""
    var channelRegisterDate = ""
    var channelValidation = ""
    
    var productSeqno = ""
    var productTerm = ""
    var productReleaseDay = ""
    var productTitle = ""
    var productPrice = ""
    var productContent = ""
    var productImage = ""
    var productRegisterDate = ""
    var productValidation = ""
    var productCategorySeqno = ""
    var productCategoryName = ""

    var feeditems_channel: NSArray = NSArray()
    var feeditems_product: NSArray = NSArray()
    var feeditems_contents: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        uSeqno = String(UserDefaults.standard.integer(forKey: "uSeqno"))
        
        self.MyContentsListSearchBar.delegate = self
        self.tvLJHContentsList.delegate = self
        self.tvLJHContentsList.dataSource = self
        self.tvLJHContentsList.rowHeight = 124
        
        // 인스턴트 만들어서 구동시켜야지.
        let myChannelSelect = MyChannelSelect()
        myChannelSelect.delegate = self
        myChannelSelect.downloadItem_myChannel(userSeqno: uSeqno)
        
        let myProductSelect = MyProductSelect()
        myProductSelect.delegate = self
        myProductSelect.downloadItem_myProduct(channelSeqno: uSeqno)
        
        let myContentsSelect = MyContentsSelect()
        myContentsSelect.delegate = self
        myContentsSelect.downloadItem_myContents(productSeqno: uSeqno)
    
        self.tvLJHContentsList.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        print("viewDidLoad()")
    }
    
    func itemDownload_myChannel(itemChannel: NSArray) {
        feeditems_channel = itemChannel

        for i in 0..<feeditems_channel.count{
            let myChannel: MyChannelModel = feeditems_channel[i] as! MyChannelModel

        channelSeqno = myChannel.chSeqno!
        channelContent = myChannel.chContext!
        channelName = myChannel.chNickname!
        channelImage =  myChannel.chImage!
        channelRegisterDate = myChannel.chRegistDate!
        channelValidation = myChannel.chValidation!
        }

//        if channelImage!.isEmpty {
//            let urlString = "http://127.0.0.1:8080/gambas/imgs/\(channelImage)"
//            let url = URL(string: urlString)
//            let data = try? Data(contentsOf: url!)
//            ivLJHChannelImage.image = UIImage(data: data!)
//        }

        lblLJHChannelName.text = channelName
        lblLJHChannelContent.text = channelContent
        lblLJHChannelRegisterDate.text = channelRegisterDate
        
    }
    
    func itemDownload_myProduct(itemProduct: NSArray) {
        feeditems_product = itemProduct
        
        for i in 0..<feeditems_product.count{
            let myProduct: MyProductModel = feeditems_product[i] as! MyProductModel
                       
            productSeqno = myProduct.prdSeqno!
            productTerm = myProduct.term!
            productReleaseDay = myProduct.releaseDay!
            productTitle = myProduct.prdTitle!
            productPrice = myProduct.prdPrice!
            productContent = myProduct.prdContext!
            productImage = myProduct.prdImage!
            productRegisterDate = myProduct.prdRegistDate!
            productValidation = myProduct.prdValidation!
            productCategorySeqno = myProduct.cgSeqno!
            productCategoryName = myProduct.cgName!
            
        }
        
//            if productImage!.isEmpty {
//                let urlString = "http://127.0.0.1:8080/gambas/imgs/\(productImage)"
//                let url = URL(string: urlString)
//                let data = try? Data(contentsOf: url!)
//                ivLJHProductImage.image = UIImage(data: data!)
//            }

        if productSeqno.isEmpty {
            ivLJHProductImage.isHidden = true
            lblLJHProductName.isHidden = true
            lblLJHProductContent.isHidden = true
            lblLJHProductCategory.isHidden = true
            lblLJHProductRegisterDate.isHidden = true
            lblLJHProductTerm.isHidden = true
            lblLJHProductDay.isHidden = true
            lblLJHProductPrice.isHidden = true
        }else{
            lblLJHProductName.text = productTitle
            lblLJHProductContent.text = productContent
            lblLJHProductCategory.text = productCategoryName
            lblLJHProductRegisterDate.text = productRegisterDate
            lblLJHProductTerm.text = productTerm
            lblLJHProductDay.text = productReleaseDay
            lblLJHProductPrice.text = productPrice
        }

    }
    
    func itemDownload_myContents(itemContents: NSArray) {
        feeditems_contents = itemContents
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "sgMyChannelProductEdit"{
            let myChannelProductEditViewController = segue.destination as! MyChannelProductEditViewController

            myChannelProductEditViewController.receiveItems_myChannelProduct(channelSeqno, channelContent, channelName, channelImage, channelRegisterDate, channelValidation, productSeqno, productTerm, productReleaseDay, productTitle, productPrice, productContent, productImage, productRegisterDate, productValidation, productCategorySeqno, productCategoryName)
            
            print("prepare()")
        }
        
        if segue.identifier == "sgMyContentsAdd"{
            let myContentsAddViewController = segue.destination as! MyContentsAddViewController

            myContentsAddViewController.receiveItems_myProductSeqno(productSeqno)
            
            print("prepare()")
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let myChannelSelect = MyChannelSelect()
        myChannelSelect.delegate = self
        myChannelSelect.downloadItem_myChannel(userSeqno: uSeqno) // 절대값***
        
        let myProductSelect = MyProductSelect()
        myProductSelect.delegate = self
        myProductSelect.downloadItem_myProduct(channelSeqno: "1") // 절대값***
        
        let myContentsSelect = MyContentsSelect()
        myContentsSelect.delegate = self
        myContentsSelect.downloadItem_myContents(productSeqno: "1") // 절대값***
        
        print("viewWillAppear()")
    }
    
}//----


extension MyChannelTableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let myContentsSelect = MyContentsSelect()
        myContentsSelect.delegate = self
        myContentsSelect.searchItem_myContents(productSeqno: productSeqno, keyword: searchBar.text!)
    }
}
