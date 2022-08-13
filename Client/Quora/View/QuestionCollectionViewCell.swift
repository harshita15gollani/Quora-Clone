//
//  QuestionCollectionViewCell.swift
//  Quora
//
//  Created by Harshita Gollani on 06/08/22.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var viewAnswer: UIButton!
    @IBOutlet weak var question: UILabel!
    var viewAllAnswer: (() -> Void)?

    @IBAction func viewAnswer(_ sender: Any) {
        viewAllAnswer?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewAnswer.layer.cornerRadius = 10.0
        // Initialization code
    }

}
