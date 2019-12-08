//
//  CustomTableViewCell.swift
//  Xebia_Test_BaljeetSingh
//
//  Created by Baljeet Singh Raghav on 08/12/19.
//  Copyright © 2019 Baljeet Singh Raghav. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var strDatePublish: UILabel!
    @IBOutlet weak var lbl_Byline: UILabel!
    @IBOutlet weak var lblTitleArticle: UILabel!
    @IBOutlet weak var imagevProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
