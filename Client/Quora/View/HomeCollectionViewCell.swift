//
//  HomeCollectionViewCell.swift
//  Quora
//
//  Created by Harshita Gollani on 04/08/22.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var continueRead: UIButton!
//    @IBOutlet weak var upvote: UIButton!
//    @IBOutlet weak var devote: UIButton!
    var continueReadingHandler: (() -> Void)?
    @IBAction func continueRead(_ sender: Any) {
        continueReadingHandler?()
    }
    
//    @IBAction func upvote(_ sender: Any) {
//    }
//    
//    @IBAction func devote(_ sender: Any) {
//    }
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        profileImage.layer.masksToBounds = true
//                profileImage.layer.cornerRadius = profileImage.bounds.width / 2
        profileImage.layer.cornerRadius = 25.0
        continueRead.layer.cornerRadius = 10
        
    }

}
