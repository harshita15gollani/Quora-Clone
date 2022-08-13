//
//  FollowCollectionViewCell.swift
//  Quora
//
//  Created by Harshita Gollani on 06/08/22.
//

import UIKit

class FollowCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var follow: UIButton!
    var count: Int? = 0
    
    @IBAction func follow(_ sender: Any) {
        if (count ?? 0) % 2 == 0 {
            follow.setTitle("👤Followed", for: .normal)
        }else {
            follow.setTitle("👤Follow", for: .normal)
        }
        count = (count ?? 0)+1
     
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = 25.0
        // Initialization code
    }

}
