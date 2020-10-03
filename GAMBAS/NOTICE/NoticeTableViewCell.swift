//
//  NoticeTableViewCell.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/10/03.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {

    @IBOutlet weak var ivNoticeImage: UIImageView!
    @IBOutlet weak var lbNoticeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
