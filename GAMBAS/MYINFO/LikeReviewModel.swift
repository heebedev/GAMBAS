//
//  LikeReviewModel.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/10/03.
//  Copyright © 2020 TJ. All rights reserved.
//

import Foundation


class LikeReviewModel: NSObject {
    
    var title: String?
    var subTitle: String?
    
    
    override init() {
    }
    
    init(title:String, subTitle:String) {
        self.title = title
        self.subTitle = subTitle
    }
    
}
