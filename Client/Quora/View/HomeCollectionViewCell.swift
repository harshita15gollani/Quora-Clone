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

    var continueReadingHandler: (() -> Void)?
    @IBAction func continueRead(_ sender: Any) {
        continueReadingHandler?()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = 25.0
        continueRead.layer.cornerRadius = 10
        
    }

}
