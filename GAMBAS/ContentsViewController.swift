//
//  SubscribeViewController.swift
//  GAMBAS
//
//  Created by Songhee Choi on 2020/09/17.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import WebKit //** 추가
import Firebase


class ContentsViewController: UIViewController, ContentsViewQueryModelProtocol, UITableViewDataSource, UITableViewDelegate, CommentListQueryModelProtocol {
    
    // 아웃렛 연결 //
    // 콘텐츠 디테일
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView! // 인디케이터
    @IBOutlet weak var myWebView: WKWebView! // 웹뷰
    
    @IBOutlet weak var lbl_countlikecontents: UILabel!
    @IBOutlet weak var lbl_ctContext: UILabel!
    
    // 좋아요
    @IBOutlet weak var btn_unlike: UIButton!
    @IBOutlet weak var btn_liked: UIButton!
    
    // 댓글 입력
    @IBOutlet weak var tf_insertComment: UITextField!
    
    // 댓글테이블
    @IBOutlet weak var tableview_comment: UITableView!
    
    
    
    // 변수 //
    var contentsViewFeedItem: NSArray = NSArray() // 콘텐츠디테일 프로토콜 받는 변수
    var commentListFeedItem: NSArray = NSArray() // 댓글 리스트 프로토콜 받는 변수
    var receive_ctSeqno = "" // ctSeqno 세그 받는 변수
    var receive_prdSeqno = "" // prdSeqno 세그 받는 변수
    
    
    // 함수 //
    // 웹페이지 로드 함수
    func loadWebPage(url: String){ // String 값으로 줘야함
        let myUrl = URL(string:url) //String으로 들어온것을 URL로 바꿔줌
        let myRequest = URLRequest(url: myUrl!) // URL 가져온거 보냄
        myWebView.load(myRequest) // 웹뷰에 불러와서 띄움
        
        // Web View가 Loading 중 인지 확인
        myWebView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }
    
    // 로딩중일때 Indicator 표시 함수 : Web View 보다 아래에 있어야 보임
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // 위에 있는 키패스값이 이걸 불러들임.
        if keyPath == "loading"{
            if myWebView.isLoading{
                myActivityIndicator.stopAnimating()
                myActivityIndicator.isHidden = false
            }else{
                myActivityIndicator.startAnimating()
                myActivityIndicator.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        uSeqno = String(UserDefaults.standard.integer(forKey: "uSeqno"))
        // 테스트 지우면됨
        print("static uSeqno테스트", uSeqno!)
        uSeqno = "1" // test : 지우면됨
        print("uSeqno테스트", uSeqno!)
        
        //테이블뷰 delegate 처리
        self.tableview_comment.delegate = self
        self.tableview_comment.dataSource = self
        
        // 셀 사이즈 댓글내용에 따라 크기 변경하게 해야하는데...ㅠㅠ
        self.tableview_comment.rowHeight = 80
        
        // 콘텐츠뷰 프로토콜 받을 작업
        let contentsViewQueryModel = ContentsViewQueryModel()
        contentsViewQueryModel.delegate = self
        contentsViewQueryModel.contentsViewdownloadItems(ctSeqno: receive_ctSeqno, uSeqno: uSeqno)
        
        // 댓글 프로토콜 받을 작업
        let commentListQueryModel = CommentListQueryModel()
        commentListQueryModel.delegate = self
        commentListQueryModel.commentListdownloadItems(ctSeqno: receive_ctSeqno)
        
        
    }
    
    // 입력 후 DB에서 다시 읽어 들이기
    override func viewWillAppear(_ animated: Bool) {
        let contentsViewQueryModel = ContentsViewQueryModel()
        contentsViewQueryModel.delegate = self
        contentsViewQueryModel.contentsViewdownloadItems(ctSeqno: receive_ctSeqno, uSeqno: uSeqno)
        
        // 댓글 프로토콜 받을 작업
        let commentListQueryModel = CommentListQueryModel()
        commentListQueryModel.delegate = self
        commentListQueryModel.commentListdownloadItems(ctSeqno: receive_ctSeqno)
        
        
    }
    
    // contentsList에서 넘겨받은 ctSeqno
    func contentsInfoReceiveItems(_ ctSeqno:String, prdSeqno:String){
        receive_ctSeqno = ctSeqno
        receive_prdSeqno = prdSeqno
        
    }
    
    // 콘텐츠뷰 프로토콜 받음
    func contentsViewItemDownloaded(items: NSArray) {
        contentsViewFeedItem = items
        let itemContentsView: SubscribeDBModel = contentsViewFeedItem[0] as! SubscribeDBModel
        
        // set 콘텐츠뷰
        lbl_countlikecontents.text = itemContentsView.countlikecontents
        lbl_ctContext.text = itemContentsView.ctContext
        
        let storage = Storage.storage()
        let storageRef = storage.reference(withPath: "contentsFolder/" + itemContentsView.ctfile!)
        
        storageRef.downloadURL { url, error in
          if let error = error {
            print(error)
          } else {
            self.loadWebPage(url: url!.absoluteString)
          }
        }
        
        //loadWebPage(url: "http://192.168.2.10:8080/ftp/\(itemContentsView.ctfile!)") // 파이어베이스 url로 변경 !
        
        // 내가 좋아요했는지 확인하고 버튼 숨기기 0 = unlike 보이기, 1 = liked 보이기
        if itemContentsView.checkmylikecontents! == "0" {
            btn_unlike.isHidden = false
            btn_liked.isHidden = true
        }else{
            btn_unlike.isHidden = true
            btn_liked.isHidden = false
        }
        
        
    }
    
    
    // 댓글 프로토콜 받음
    func commentListItemDownloaded(items: NSArray) {
        commentListFeedItem = items
        self.tableview_comment.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentListFeedItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentsViewCell", for: indexPath) as! ContentsViewTableViewCell
        
        // Configure the cell...
        let item: SubscribeDBModel = commentListFeedItem[indexPath.row] as! SubscribeDBModel
        
        //text
        cell.lbl_uName?.text = "\(item.uName!)"
        
        // 날짜만 자르기
        let formatRegistDate = "\(item.cmRegistDate!)"
        let endIdx: String.Index = formatRegistDate.index(formatRegistDate.startIndex, offsetBy: 15)
        let result = String(formatRegistDate[...endIdx])
        cell.lbl_cmRegistDate?.text = result
        //print("댓글내용", item.cmcontext!)
        cell.tv_cmcontext?.text = "\(item.cmcontext!)"
        
        return cell
    }
    
    
    
    // 삭제 할때
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // 몇번째인지 확인
        let item: SubscribeDBModel = commentListFeedItem[indexPath.row] as! SubscribeDBModel // DB 모델타입으로 바꾸고, data 뽑아 쓸 수 있음
        
        // 댓글 쓴 사람과 일치할때 삭제하기
        if uSeqno == item.uSeqno {
            if editingStyle == .delete {
                // Delete the row from the data source
                
                // 삭제 누르면 cmValidatio = 1 -> 0으로 update
                let updateModel = CommentInsertUpdateModel() // 인스턴스 생성
                updateModel.UpdateItems(cmSeqno: item.cmSeqno!)
                
                // 댓글 테이블 다시 불러옴
                let commentListQueryModel = CommentListQueryModel()
                commentListQueryModel.delegate = self
                commentListQueryModel.commentListdownloadItems(ctSeqno: receive_ctSeqno)
            }
        }
    }
    
    
    // 삭제시 Delete를 삭제(한글)로 바꿔주기:  추가
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    
    
    // 액션 //
    // 좋아요 누르기
    @IBAction func btn_insertLike(_ sender: UIButton) {
        btn_unlike.isHidden = true
        btn_liked.isHidden = false
        
        let get_uSeqno = uSeqno!
        let get_ctSeqno = receive_ctSeqno
        let get_prdSeqno = receive_prdSeqno
        //print(get_uSeqno, get_ctSeqno, get_prdSeqno)
        
        let insertModel = LikeInsertUpdateModel() // 인스턴스 생성
        insertModel.InsertItems(uSeqno: get_uSeqno, ctSeqno: get_ctSeqno, prdSeqno: get_prdSeqno)// result Bool 받아와서 쓰기위해
        
        // 총 좋아요갯수 + 1
        lbl_countlikecontents.text = String(Int(lbl_countlikecontents.text!)! + 1)
    }
    
    // 좋아요 해제
    @IBAction func btn_updateLike(_ sender: UIButton) {
        btn_liked.isHidden = true
        btn_unlike.isHidden = false
        
        let get_uSeqno = uSeqno!
        let get_ctSeqno = receive_ctSeqno
        
        print(get_uSeqno, get_ctSeqno)
        
        let updateModel = LikeInsertUpdateModel() // 인스턴스 생성
        updateModel.UpdateItems(uSeqno: get_uSeqno, ctSeqno: get_ctSeqno)// result Bool 받아와서 쓰기위해
        
        
        // 총 좋아요갯수 -1
        lbl_countlikecontents.text = String(Int(lbl_countlikecontents.text!)! - 1)
        
    }
    
    //
    @IBAction func btn_insertComment(_ sender: UIButton) {
        let get_uSeqno = uSeqno!
        let get_ctSeqno = receive_ctSeqno
        let get_cmcontext = tf_insertComment.text
        print(get_uSeqno, get_ctSeqno, get_cmcontext!)
        
        let insertModel = CommentInsertUpdateModel() // 인스턴스 생성
        insertModel.InsertItems(uSeqno: get_uSeqno, ctSeqno: get_ctSeqno, cmcontext: get_cmcontext!)// result Bool 받아와서 쓰기위해
        
        // 댓글 입력창 초기화
        tf_insertComment.text = ""
        
        // 댓글 리스트 업데이트 
        let commentListQueryModel = CommentListQueryModel()
        commentListQueryModel.delegate = self
        commentListQueryModel.commentListdownloadItems(ctSeqno: receive_ctSeqno)
        
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


// table view cell
class ContentsViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_uName: UILabel!
    @IBOutlet weak var lbl_cmRegistDate: UILabel!
    @IBOutlet weak var tv_cmcontext: UITextView!
    
}
