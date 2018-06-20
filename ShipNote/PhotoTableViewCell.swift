//
//  PhotoTableViewCell.swift
//  ShipNote
//
//  Created by User03 on 2018/6/20.
//  Copyright © 2018年 User03. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photoTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
