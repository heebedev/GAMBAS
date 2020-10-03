//
//  LikeReviewTableViewCell.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/10/04.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class LikeReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
