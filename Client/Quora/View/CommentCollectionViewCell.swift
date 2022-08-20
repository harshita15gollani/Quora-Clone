//
//  CommentCollectionViewCell.swift
//  Quora
//
//  Created by Harshita Gollani on 05/08/22.
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var comment1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // add.layer.cornerRadius = 8
        // Initialization code
    }

}
