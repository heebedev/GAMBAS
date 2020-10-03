//
//  cashTableViewCell.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/10/03.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class cashTableViewCell: UITableViewCell {

    @IBOutlet var myCashDate: UILabel!
    @IBOutlet var myCashPoint: UILabel!
    @IBOutlet var myProductTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
