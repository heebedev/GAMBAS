//
//  MyContentsListTableViewCell.swift
//  GAMBAS
//
//  Created by TJ on 2020/09/17.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class MyContentsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivLJHContentsImage: UIImageView!
    @IBOutlet weak var lblLJHContentsTitle: UILabel!
    @IBOutlet weak var lblLJHContentsRegisterDate: UILabel!
    @IBOutlet weak var lblLJHContentsContent: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
