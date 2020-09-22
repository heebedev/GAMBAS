//
//  ViewController.swift
//  pTest
//
//  Created by SSB on 18/09/2020.
//  Copyright © 2020 SSB. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    let uSeqno: Int = 2 // ***Test용
    let queryModel = UCategoryQueryModel()
    
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var writingView: UIView!
    @IBOutlet weak var drawingView: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var musicView: UIView!
    @IBOutlet weak var otherView: UIView!
    
    var categories: [String] = []
    var cView: [UIView] = []
    
    var recentRecommendListViewController: RecommendListViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? RecommendListViewController
        recentRecommendListViewController = destinationVC
        
        if segue.identifier == "recommend" {
            recentRecommendListViewController.viewModel.updateType(.recommend)
            destinationVC?.receiveCategory = "추천"
        } else if segue.identifier == "writing" {
            recentRecommendListViewController.viewModel.updateType(.writing)
            destinationVC?.receiveCategory = "글"
        } else if segue.identifier == "drawing" {
            recentRecommendListViewController.viewModel.updateType(.drawing)
            destinationVC?.receiveCategory = "그림"

        } else if segue.identifier == "video" {
            recentRecommendListViewController.viewModel.updateType(.vdieo)
            destinationVC?.receiveCategory = "영상"

        } else if segue.identifier == "music" {
            recentRecommendListViewController.viewModel.updateType(.music)
            destinationVC?.receiveCategory = "음악"

        } else if segue.identifier == "other" {
            recentRecommendListViewController.viewModel.updateType(.other)
            destinationVC?.receiveCategory = "기타"

        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        queryModel.getUserCategoryList(uSeqno: uSeqno) { (returnList) in
            DispatchQueue.main.async { () -> Void in
                if returnList != nil {
                    for category in returnList! {
                        let index = Int(category)
                        self.cView[index!-1].isHidden = false }
                }
            }
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cView = [writingView, drawingView, videoView, musicView, otherView]
        
        for i in 0..<5 {
            cView[i].isHidden = true
        }
    }
    
    
    
}

