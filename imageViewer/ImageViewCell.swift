//
//  ImageViewCell.swift
//  imageViewer
//
//  Created by Fedor Lvov on 30/08/2019.
//  Copyright © 2019 Fedor Lvov. All rights reserved.
//

import UIKit

class ImageViewCell: UITableViewCell {

    @IBOutlet weak var randomImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
