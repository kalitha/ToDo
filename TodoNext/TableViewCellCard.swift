//
//  TableViewCellCard.swift
//  TodoNext
//
//  Created by Kalitha H N on 23/02/17.
//  Copyright © 2017 next. All rights reserved.
//

import UIKit

class TableViewCellCard: UITableViewCell {

    @IBOutlet weak var mDescription: UILabel!
    @IBOutlet weak var mCreatedTime: UILabel!
    @IBOutlet weak var mTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //mTextView.isEditable = false
        let color = UIColor.init(red: 240/255, green: 237/255, blue: 234/255, alpha: 1)
        //mView.layer.shadowColor = UIColor.lightGray.cgColor
       // mView.layer.borderColor = color.cgColor
        //mView.layer.backgroundColor = color.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
       
    
}
