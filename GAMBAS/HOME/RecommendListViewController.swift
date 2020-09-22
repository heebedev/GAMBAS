
//
//  RecommendListViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/02.
//  Copyright © 2020 com.joonwon. All rights reserved.
//
import UIKit
class RecommendListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, QueryModelProtocol, CategoryProtocol {
    
    
    let uSeqno: Int = UserDefaults.standard.integer(forKey: "uSeqno")
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var lblrecentSellProduct: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    let viewModel = RecommentListViewModel()
    var feedItem: NSArray = NSArray()
    var receiveCategory = ""
    var categories: [String] = []
    
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
    
    func categoryDownloaded(items: [String]) {
        categories = items
        self.listCollectionView?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let uQueryModel = UCategoryQueryModel()
        let queryModel = CategoryQueryModel()
        queryModel.delegate = self
        uQueryModel.delegate = self
        
        if receiveCategory == "추천" {
            uQueryModel.getUserCategoryList(uSeqno: uSeqno) {isValid in
                DispatchQueue.main.async { () -> Void in
                    if isValid {
                        let arraytostring = self.categories.joined(separator: ",")
                        queryModel.downloadRecommendItems(category: arraytostring)
                    }
                }
            }
        } else {
            queryModel.downloadItems(category: receiveCategory)
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
        cell.chnnelNickname.text = item.chNickname
        cell.releaseDay.text = item.releaseDay
        cell.term.text = "(\(item.term!))"
        cell.price.text = "\(item.prdPrice!) 원"
        cell.subsNumber.text = "\(item.prdcount!) 구독"
        cell.totalLike.text = item.clike
        
        cell.imgView.layer.cornerRadius = 5
        cell.imgView.layer.masksToBounds = true
        
        let url = URL(string: "http://localhost:8080/ftp/\(item.prdImage!)")! // 원래이름 ( tomcat 서버에 넣어놓음)
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
            }else{
                DispatchQueue.main.async {
                    cell.imgView?.image = UIImage(data: data!)
                    // jpg
                    if let image = UIImage(data: data!){
                        if let data = image.jpegData(compressionQuality: 0.8){// 일반적으로 80% 압축
                            let filename = self.getDecumentDirectory().appendingPathComponent("recent.jpg") // 다운받을때 이미지이름 설정(동일한이름 들어가면 1,2 로변함)
                            try? data.write(to: filename)
                            print("Data is writed")
                            
                        }
                    }
                    
                    // png 쓸 때 사용
                    if let image = UIImage(data: data!){
                        if let data = image.pngData() {//
                            let filename = self.getDecumentDirectory().appendingPathComponent("recent.jpg") // // 다운받을때 이미지이름
                            try? data.write(to: filename)
                            print("Data is writed")
                            
                            
                        }
                    }
                }
            }
        }
        task.resume() // task 실행
        return cell
    }
    
    
    // write 위치 (스마트폰의)
    func getDecumentDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0] // 첫번째 값 앱에 설정한 것의 위치
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
