//
//  resultsCell.swift
//  ChatApp
//
//  Created by Morteza Araby on 2016-10-23.
//  Copyright © 2016 Morteza Araby. All rights reserved.
//

import UIKit

class resultsCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        profileImg.setRounded()
    }

}
