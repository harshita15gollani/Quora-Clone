//
//  SearchViewController.swift
//  Quora
//
//  Created by Harshita Gollani on 07/08/22.
//

import UIKit

class SearchViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,NewProfileManagerDelegate {
    
    var profileid:String?

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userDescription: UILabel!
    
    @IBOutlet weak var userFollowers: UIButton!
    
    @IBOutlet weak var userFollowing: UIButton!
    
    @IBOutlet weak var followers: UILabel!
    
    @IBOutlet weak var following: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var followProfile: UIButton!
    
    @IBAction func userFollowers(_ sender: Any) {
        clicked = "followers"
        isTapped = true
        userCollectionView.reloadData()
    }
    @IBAction func userFollowing(_ sender: Any) {
        clicked = "following"
        isTapped = true
        userCollectionView.reloadData()
    }
    var count: Int? = 0
    @IBAction func followProfile(_ sender: Any) {
        if (count ?? 0) % 2 == 0 {
            followProfile.setTitle("👤Followed", for: .normal)
        }else {
            followProfile.setTitle("👤Follow", for: .normal)
        }
        count = (count ?? 0)+1
    }
    
    @IBOutlet weak var userCollectionView: UICollectionView!
    var profileData: ProfileModel?
    var caller: NewProfileManager?
    var clicked: String?
    var isTapped: Bool? = false
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if clicked == "followers"{
            return profileData?.followers?.count ?? 0}
        else if clicked == "following"{
            return profileData?.following?.count ?? 0
        }
        else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:370, height: 50.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowIdentifier",for: indexPath) as? FollowCollectionViewCell else {
            print("Failed to create custom cell")
            return UICollectionViewCell()
        }

        if isTapped == true{
            cell.isHidden = false
        if clicked == "followers"{
            cell.name.text = profileData?.followers?[indexPath.row].userName
            self.loadImage(urlString:profileData?.followers?[indexPath.row].profileImage , imageView: cell.profileImage)
        }
        else if clicked == "following"{
            cell.name.text = profileData?.following?[indexPath.row].userName
            self.loadImage(urlString:profileData?.following?[indexPath.row].profileImage , imageView: cell.profileImage)
        }
        }
        else if isTapped == false{
            cell.isHidden = true
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCustomViewInCell()
        self.navigationController?.isNavigationBarHidden = false
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        caller = NewProfileManager()
        caller?.delegate = self
        caller?.fetchProductList(searchItem: profileid ?? "")
        userImage.layer.cornerRadius = 50.0

    }
    
    func registerCustomViewInCell(){
        let nib = UINib(nibName: "FollowCollectionViewCell", bundle: nil)
        userCollectionView.register(nib , forCellWithReuseIdentifier: "FollowIdentifier")
    }
    func updateData(profileDetail: ProfileModel) {
        profileData = profileDetail
        DispatchQueue.main.async {
            self.userCollectionView.reloadData()
            self.updateProfile()
        }
    }
    func updateProfile(){
        self.loadImage(urlString: profileData?.profileImage, imageView: userImage)
        userName.text = profileData?.userName
        userDescription.text = profileData?.description
        if let profileData = profileData, let noOfFollowers = profileData.noOfFollowers{
            followers.text = "\(noOfFollowers)"
        }
        if let profileData = profileData, let noOfFollowing = profileData.noOfFollowing{
            following.text = "\(noOfFollowing)"
        }
        if let profileData = profileData, let score = profileData.score{
            self.score.text = "\(score)"
        }
    }
    func loadImage(urlString: String?, imageView: UIImageView)  {
            if let unwrappedString = urlString,
               let url = URL(string: unwrappedString) {
                print(unwrappedString)
                DispatchQueue.global(qos: .background).async {
                    do {
                        let imageData = try Data(contentsOf: url)
                        DispatchQueue.main.async {
                            let loadedImage = UIImage(data: imageData)
                            imageView.image = loadedImage
                            imageView.contentMode = .scaleAspectFit
                        }
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }


}
