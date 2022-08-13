//
//  MySearchCollectionViewCell.swift
//  Quora
//
//  Created by Harshita Gollani on 12/08/22.
//

import UIKit

class MySearchCollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var followers: UILabel!
    
    @IBOutlet weak var following: UILabel!
    
    
    @IBOutlet weak var profile: UIButton!
    @IBOutlet weak var follow: UIButton!
    @IBOutlet weak var score: UILabel!
    
 
    @IBOutlet weak var userDescription: UILabel!
    var count: Int? = 0
    
    @IBAction func follow(_ sender: Any) {
        if (count ?? 0) % 2 == 0 {
            follow.setTitle("👤Followed", for: .normal)
        }else {
            follow.setTitle("👤Follow", for: .normal)
        }
        count = (count ?? 0)+1
     
    }
    var viewProfile: (() -> Void)?
    @IBAction func profile(_ sender: Any) {
        viewProfile?()
//        if productData?.first?.accountType == "Public" || productData?.first?.accountType == "Corporate" {
//             if let searchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SearchViewController") as? SearchViewController  {
//        navigationController?.pushViewController(searchViewController, animated: true)
//    }
//        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        profile.layer.cornerRadius = 5
        userImage.layer.cornerRadius = 50.0
        // Initialization code
    }

}
