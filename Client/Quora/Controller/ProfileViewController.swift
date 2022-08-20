//
//  ProfileViewController.swift
//  Quora
//
//  Created by Harshita Gollani on 06/08/22.
//

import UIKit

class ProfileViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,ProfileManagerDelegate {
   
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    
    @IBOutlet weak var userFollowers: UIButton!
    
    @IBOutlet weak var userFollowing: UIButton!
    
    @IBOutlet weak var followers: UILabel!
    
    @IBOutlet weak var following: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
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
    
    var isTapped: Bool? = false
    var clicked: String?
    @IBOutlet weak var userCollectionView: UICollectionView!
   
    
    var profileData: ProfileModel?
    var caller: ProfileManager?
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
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        caller = ProfileManager()
        caller?.delegate = self
        caller?.fetchProductList(searchItem: "")
        userImage.layer.cornerRadius = 50.0

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        caller?.fetchProductList(searchItem: "")
    }
    func updateProfile(){
        self.loadImage(urlString: "https://avatars.githubusercontent.com/u/69767?v=4", imageView: userImage)

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
