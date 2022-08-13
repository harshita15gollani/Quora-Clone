//
//  AnswerDescriptionCollectionViewCell.swift
//  Quora
//
//  Created by Harshita Gollani on 05/08/22.
//

import UIKit

protocol AnswerDescriptionDelegate: AnyObject {
    func commentTrigger(answerId:String)
}

class AnswerDescriptionCollectionViewCell: UICollectionViewCell {
    
    var delegate:AnswerDescriptionDelegate?

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var upvote: UIButton!
    @IBOutlet weak var devote: UIButton!
    @IBOutlet weak var comment: UIButton!
    var answerId:String?
    @IBAction func upvote(_ sender: Any) {
        upvote.tintColor = .red
        devote.tintColor = .black
        upvoteHandler?()
    }
    @IBAction func devote(_ sender: Any) {
        devote.tintColor = .red
        upvote.tintColor = .black
        devoteHandler?()
    }
    var passCommentsHandler: (()-> Void)?
    var upvoteHandler: (()-> Void)?
    var devoteHandler: (()-> Void)?
    @IBAction func comment(_ sender: Any) {
        self.delegate?.commentTrigger(answerId: answerId!)
        passCommentsHandler?()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = 28.5
        // Initialization code
    }

}
