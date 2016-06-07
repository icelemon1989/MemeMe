//
//  SentMemeTableViewCell.swift
//  MemeMe
//
//  Created by Yang Ji on 6/6/16.
//  Copyright © 2016 Yang Ji. All rights reserved.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTopLabel: UILabel!
    @IBOutlet weak var memeBottonLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
