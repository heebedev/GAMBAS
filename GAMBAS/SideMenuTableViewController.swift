//
//  SideMenuTableViewController.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/09/23.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    
    var menuList = ["로그아웃", "채널관리"]
    var menuListSolo = ["로그아웃"]
    
    let uCRCode: Int = UserDefaults.standard.integer(forKey: "uCRCode")
    
    @IBOutlet var sideTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sideTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows'
        var result = 0
        
        if uCRCode == 1 {
            result = menuListSolo.count
        } else {
            result =  menuList.count
        }
        return result
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        
        if uCRCode == 1 {
            cell.textLabel?.text = menuListSolo[indexPath.row]
        } else {
            cell.textLabel?.text = menuList[indexPath.row]
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0) {
            let board = UIStoryboard.init(name: "Main", bundle: nil)
            guard let detailVC = board.instantiateViewController(withIdentifier: "LoginPage") as? LoginViewController else {return}
            detailVC.modalPresentationStyle = .fullScreen
            
            UserDefaults.standard.removeObject(forKey: "uSeqno")
            detailVC.modalPresentationStyle = .fullScreen
            // 이동
            self.present(detailVC, animated: true, completion: nil)
        } else {
            let board = UIStoryboard.init(name: "Main", bundle: nil)
            // 네비게이션 컨트롤러 연결
            guard let detailVC = board.instantiateViewController(withIdentifier: "chManager") as? MyChannelViewController else {return} // 송희 수정
            self.navigationController?.pushViewController(detailVC, animated: true)
            
//            guard let detailVC = board.instantiateViewController(withIdentifier: "chManager") as? MyChannelViewController else {return} // 송희 수정
//            detailVC.modalPresentationStyle = .fullScreen
//            // 이동
//            self.present(detailVC, animated: true, completion: nil)
            
            
        }
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
