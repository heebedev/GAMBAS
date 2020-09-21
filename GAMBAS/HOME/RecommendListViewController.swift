
//
//  RecommendListViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/02.
//  Copyright © 2020 com.joonwon. All rights reserved.
//
import UIKit
class RecommendListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, QueryModelProtocol {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    @IBOutlet weak var lblrecentSellProduct: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    let viewModel = RecommentListViewModel()
    var feedItem: NSArray = NSArray()
    var receiveCategory = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate 처리
        self.listCollectionView?.delegate = self
        self.listCollectionView?.dataSource = self
        updateUI()
        
    }
    
    func itemDownloaded(items: NSArray) {
        feedItem = items
        self.listCollectionView?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let queryModel = CategoryQueryModel()
        queryModel.delegate = self
        
        if receiveCategory == "추천" {
            
            
            
        } else {
            queryModel.downloadItems(category: receiveCategory) {isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        print("success")
                    } else {
                        print("fail") }
                }
            }
        }
    }
    
    func updateUI() {
        lblrecentSellProduct.text = viewModel.type.title
        
    }
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedItem.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as? RecommendCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        
        let item: CategoryDBModel = feedItem[indexPath.item] as! CategoryDBModel
        
        cell.title.text = item.prdTitle
        //cell.title.text = receiveCategory
        cell.chnnelNickname.text = item.chNickname
        cell.releaseDay.text = item.releaseDay
        cell.term.text = "(\(item.term!))"
        cell.price.text = "\(item.prdPrice!) 원"
        cell.subsNumber.text = "\(item.count!) 구독"
        
        cell.imgView.layer.cornerRadius = 5
        cell.imgView.layer.masksToBounds = true
        
        //let movie = viewModel.item(at: indexPath.item)
        //cell.updateUI(movie: movie)
        
        //let url = URL(string: "http://192.168.0.5:8080/ftp/\(item.sbImage!)")! // 원래이름 ( tomcat 서버에 넣어놓음)
        //let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        return cell
    }
    
    
    
    class RecommentListViewModel {
        enum RecommendingType {
            case recommend
            case writing
            case drawing
            case vdieo
            case music
            case other
            
            var title: String {
                switch self {
                case .recommend:
                    return "GAMBAS 추천"
                case .writing:
                    return "GAMBAS 글"
                case .drawing:
                    return "GAMBAS 그림"
                case .vdieo:
                    return "GAMBAS 영상"
                case .music:
                    return "GAMBAS 음악"
                case .other:
                    return "GAMBAS 기타"
                }
            }
        }
        
        private (set) var type: RecommendingType = .other
        
        
        func updateType(_ type: RecommendingType) {
            self.type = type
        }
        
        
    }
    
    
}
