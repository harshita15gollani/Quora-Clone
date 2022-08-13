//
//  ViewController.swift
//  Quora
//
//  Created by Harshita Gollani on 04/08/22.
//

import UIKit
import UniformTypeIdentifiers

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UISearchBarDelegate,AnswerManagerDelegate,AdsManagerDelegate {
    
   
   
       
    
    @IBOutlet weak var createPost: UIButton!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    @IBOutlet weak var adsCollectionView: UICollectionView!
    
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let refreshControl = UIRefreshControl()
    var imagePicker = UIImagePickerController()
    var answerData: [AnswerModel]? = []
    var adsData:AdsModel?
    var caller: AnswerManager?
    var callerAds:AdsManager?
    @IBAction func createPost(_ sender: Any) {
        performSegue(withIdentifier: "createPostIdentifier", sender: nil)
    }
    @IBAction func profileImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
                pickerController.sourceType = .photoLibrary
                pickerController.mediaTypes = [UTType.video.identifier, UTType.image.identifier]
                pickerController.allowsEditing = true
                pickerController.delegate = self
                present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
            print(mediaType)
            switch mediaType {
            case "public.image":
                print("image selected")
                let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
                self.profileImage.setBackgroundImage(editedImage, for: .normal)
            default:
                print("asdasdasd")
            }
            picker.dismiss(animated: true, completion: nil)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        profileImage.layer.masksToBounds = true
//        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
        self.navigationController?.isNavigationBarHidden = true
        createPost?.layer.cornerRadius = CGFloat(20.0)
        createPost?.clipsToBounds = true
        profileImage?.layer.cornerRadius = CGFloat(20.0)
        profileImage?.clipsToBounds = true
        registerCustomViewInCell()
        registerCustomViewInCellAds()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        adsCollectionView.delegate = self
        adsCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.adsCollectionView.collectionViewLayout = layout
        searchBar.delegate = self
        homeCollectionView.refreshControl = refreshControl
        caller = AnswerManager()
        callerAds = AdsManager()

        caller?.delegate = self
        caller?.fetchProductList(searchItem: "")
        callerAds?.delegate = self
        callerAds?.fetchAdsList(searchItem: "")
        
        //refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
    }
//    @objc func refreshData(){
//
//    }
    func updateData(answerDetail: [AnswerModel]) {
        self.answerData = answerDetail
        DispatchQueue.main.async {
            self.homeCollectionView.reloadData()
        }
    }
    func updateAds(AdsDetail: AdsModel) {
        self.adsData = AdsDetail
        DispatchQueue.main.async {
            self.adsCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.homeCollectionView {
            return answerData?.count ?? 0
            } else {
                return 1
            }
    }
    override func viewWillAppear(_ animated: Bool) {
        caller?.fetchProductList(searchItem: "")
        callerAds?.fetchAdsList(searchItem: "")
        self.navigationController?.isNavigationBarHidden = true
    }
//    override func viewDidAppear(_ animated: Bool) {
//        caller?.fetchProductList(searchItem: "")
//        callerAds?.fetchAdsList(searchItem: "")
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:370, height: 250.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.homeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeIdentifier",for: indexPath) as? HomeCollectionViewCell else {
                print("Failed to create custom cell")
                return UICollectionViewCell()
            }
            self.loadImage(urlString: answerData?[indexPath.row].profileImage, imageView: cell.profileImage)
            cell.name.text = answerData?[indexPath.row].userName
            cell.question.text = answerData?[indexPath.row].description
            cell.answer.text = answerData?[indexPath.row].answersList?.first?.answerDescription
            
            cell.continueReadingHandler = { [weak self] in
                if let continueViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AnswerDescriptionViewController") as? AnswerDescriptionViewController {
                    continueViewController.answers = self?.answerData?[indexPath.row].answersList
                    continueViewController.questionData = self?.answerData?[indexPath.row].description
                    continueViewController.myAnswer = self?.answerData?[indexPath.row].questionId
                    
                    self?.navigationController?.pushViewController(continueViewController, animated: true)
                }
            }
            return cell
        }
        else{
        
            guard let adsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsIdentifier",for: indexPath) as? AdsCollectionViewCell else {
                print("Failed to create custom cell")
                return UICollectionViewCell()
            }
            //adsCell.backgroundColor = UIColor.systemGray3
            self.loadImage(urlString: adsData?.image, imageView: adsCell.adsImage)
            return adsCell
        }
       
       // return UICollectionViewCell()
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MySearchViewController") as? MySearchViewController  {
            searchViewController.searchedItem = searchBar.text ?? ""
            navigationController?.pushViewController(searchViewController, animated: true)
        }
    }
    func registerCustomViewInCell(){
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        homeCollectionView.register(nib , forCellWithReuseIdentifier: "HomeIdentifier")
    }
    func registerCustomViewInCellAds(){
        let nib = UINib(nibName: "AdsCollectionViewCell", bundle: nil)
        adsCollectionView.register(nib , forCellWithReuseIdentifier: "AdsIdentifier")
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

