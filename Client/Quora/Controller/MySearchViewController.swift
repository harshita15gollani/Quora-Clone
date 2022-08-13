//
//  MySearchViewController.swift
//  Quora
//
//  Created by Harshita Gollani on 10/08/22.
//

import UIKit

class MySearchViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,SearchManagerDelegate {
    
    var productData: [SearchModel]?
    var caller: SearchManager?
    var searchedItem:String?
    @IBOutlet weak var userCollectionView: UICollectionView!
    func updateData(productDetail: [SearchModel]) {
        productData = productDetail
        DispatchQueue.main.async {
            //self.updateDetail()
            self.userCollectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MySearchIdentifier",for: indexPath) as? MySearchCollectionViewCell else {
            print("Failed to create custom cell")
            return UICollectionViewCell()
        }
        cell.userName.text = productData?.first?.userName
        cell.userDescription.text = productData?.first?.description
        self.loadImage(urlString: productData?.first?.profileImage, imageView: cell.userImage)
                if let productData = productData, let noOfFollowers = productData.first?.noOfFollowers{
                    cell.followers.text = "\(noOfFollowers)"
                }
                if let productData = productData, let noOfFollowing = productData.first?.noOfFollowing{
                    cell.following.text = "\(noOfFollowing)"
                }
                if let productData = productData, let score = productData.first?.score{
                    cell.score.text = "\(score)"
                }
        cell.viewProfile = { [weak self] in
            if self?.productData?.first?.accountType == "Public" || self?.productData?.first?.accountType == "Corporate" {
                         if let searchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SearchViewController") as? SearchViewController  {
                            searchViewController.profileid = self?.productData?.first?.id
                            self?.navigationController?.pushViewController(searchViewController, animated: true)
                }
                    }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:370, height: 100.0)
    }
//    func updateDetail(){
//        userName.text = productData?.first?.userName
//        userDescription.text = productData?.first?.description
//        self.loadImage(urlString: productData?.first?.profileImage, imageView: userImage)
//        if let productData = productData, let noOfFollowers = productData.first?.noOfFollowers{
//            followers.text = "\(noOfFollowers)"
//        }
//        if let productData = productData, let noOfFollowing = productData.first?.noOfFollowing{
//            following.text = "\(noOfFollowing)"
//        }
//        if let productData = productData, let score = productData.first?.score{
//            self.score.text = "\(score)"
//        }
//    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        registerCustomViewInCell()
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        
        caller = SearchManager()
        caller?.delegate = self
        caller?.fetchProductList(searchItem: searchedItem ?? "")
         //updateDetail()
        
       
        // Do any additional setup after loading the view.
    }
    func registerCustomViewInCell(){
        let nib = UINib(nibName: "MySearchCollectionViewCell", bundle: nil)
        userCollectionView.register(nib , forCellWithReuseIdentifier: "MySearchIdentifier")
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
