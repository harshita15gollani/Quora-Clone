//
//  CommentViewController.swift
//  Quora
//
//  Created by Harshita Gollani on 05/08/22.
//

import UIKit

class CommentViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,CommentManagerDelegate {
    
    
    @IBOutlet weak var cancel: UIButton!
    
    @IBOutlet weak var post: UIButton!
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var comment: UITextView!
    var myCommentId:String?
    var commentData: CommentModel?
    var caller: CommentManager?
    var lastAns = ""
    @IBAction func post(_ sender: Any) {
       
        if var tempAns = myCommentId{
            lastAns = tempAns
        }
        guard let url = URL(string: "http://10.20.4.131:8082/comment/addComment/62f0b97e8c8ca2093f142979") else {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let body: [String: Any] = [

                    "commentText":comment.text,
                       "codeEmbed":"fhf",
                       "urlEmbed":"gnvn",
                       "accountId":"62f0b97e8c8ca2093f142979",
                       "level":0,
                       "answerId":"\(lastAns)",
                    "parentId":"\(lastAns)"

                ]
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
                //request.setValue("application/json", forHTTPHeaderField: "Authorization")
                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    guard let data = data,error == nil else{
                        return
                    }
                    do{
                        let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        print("Success: \(response)")
                    }
                    catch {
                        print(error)
                    }
                }
                task.resume()
    }
    
    @IBOutlet weak var commentView: UICollectionView!
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return commentData?.nestedComment?.count ?? 0
    }
    func updateData(profileDetail: CommentModel) {
        self.commentData = profileDetail
        DispatchQueue.main.async {
            self.commentView.reloadData()
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentIdentifier",for: indexPath) as? CommentCollectionViewCell else {
            print("Failed to create custom cell")
            return UICollectionViewCell()
        }

        if commentData?.nestedComment?.count == 0{
            cell.isHidden = true
        }
        else{
            cell.comment1.text = commentData?.nestedComment?[indexPath.row].commentText
            self.loadImage(urlString: commentData?.nestedComment?[indexPath.row].profileImage, imageView: cell.commentImage)
        }
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:380, height: 70.0)
    }
    
    func registerCustomViewInCell(){
        let nib = UINib(nibName: "CommentCollectionViewCell", bundle: nil)
        commentView.register(nib , forCellWithReuseIdentifier: "CommentIdentifier")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        post.layer.cornerRadius = 10.0
        registerCustomViewInCell()
        commentView.delegate = self
        commentView.dataSource = self
        caller = CommentManager()
        caller?.delegate = self
        print(myCommentId)
        caller?.fetchProductList(searchItem: myCommentId ?? "")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        caller?.fetchProductList(searchItem: myCommentId ?? "")
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
