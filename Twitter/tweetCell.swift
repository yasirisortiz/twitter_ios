//
//  tweetCell.swift
//  Twitter
//
//  Created by Yasiris Ortiz on 11.10.20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
