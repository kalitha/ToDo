//
//  ProfilePic.swift
//  TodoNext
//
//  Created by Kalitha H N on 21/02/17.
//  Copyright © 2017 next. All rights reserved.
//

import UIKit

class ProfilePic: UITableViewCell {

    @IBOutlet weak var mEmailId: UILabel!
    @IBOutlet weak var mUserPic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mUserPic.layer.cornerRadius = mUserPic.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
