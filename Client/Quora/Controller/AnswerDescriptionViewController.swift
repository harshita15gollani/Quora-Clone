//
//  AnswerDescriptionViewController.swift
//  Quora
//
//  Created by Harshita Gollani on 05/08/22.
//

import UIKit

class AnswerDescriptionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,AnswerDescriptionDelegate {
    
    
    
    @IBOutlet weak var answerCollectionView: UICollectionView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var questionUpvote: UIButton!
    @IBOutlet weak var questionDevote: UIButton!
    
    @IBAction func questionUpvote(_ sender: Any) {
        questionUpvote.tintColor = .red
        questionDevote.tintColor = .black
        print("clicked")
        print(myAnswer)
        var lastAns = ""
        if var tempAns = myAnswer{
            lastAns = tempAns
        }
        print(lastAns)
        guard let url = URL(string:"http://10.20.4.131:8082/question/upVoteQuestion/\(lastAns)") else {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "token")
//                let body: [String: Any] = [
//
//
//
//
//                ]
//                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
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
    
    @IBAction func questionDevote(_ sender: Any) {
        questionDevote.tintColor = .red
        questionUpvote.tintColor = .black
        var lastAns = ""
        if var tempAns = myAnswer{
            lastAns = tempAns
        }
        print(lastAns)
        guard let url = URL(string:"http://10.20.4.131:8082/question/downVoteQuestion/\(lastAns)") else {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "token")
//                let body: [String: Any] = [
//
//
//
//
//                ]
//                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
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
    var myAnswers:[CommentsLevel]?
    var answers: [AnswersList]?
    var questionData: String?
    var myAnswer: String?
    var tempAnswerId:String?
    //var commentList: [AnswersList]?
    //var myComment:String?
    @IBOutlet weak var answer: UIButton!
    
    @IBAction func answer(_ sender: Any) {
        performSegue(withIdentifier: "answerIdentifier", sender: nil)
    }
    var commentDetails: [CommentsLevel]?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "answerIdentifier" {
            guard let nextScreen = segue.destination as? AnswerViewController else {
                return
            }
            print(myAnswer)
            nextScreen.myAnswerId = myAnswer
        }
        if segue.identifier == "commentIdentifier" {
            guard let nextScreen = segue.destination as? CommentViewController else {
                return
            }
           // nextScreen.commentList = commentDetails
            
            nextScreen.myCommentId = tempAnswerId
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answers?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:400, height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerDescriptionIdentifier",for: indexPath) as? AnswerDescriptionCollectionViewCell else {
            print("Failed to create custom cell")
            return UICollectionViewCell()
        }
        self.loadImage(urlString: answers?[indexPath.row].profileImage, imageView: cell.profileImage)
        cell.name.text = answers?[indexPath.row].userName
        cell.delegate = self
        cell.answer.text = answers?[indexPath.row].answerDescription
        cell.answerId = answers?[indexPath.row].answerId
        commentDetails = answers?[indexPath.row].commentsLevel
        var currentAnsId = answers?[indexPath.row].answerId
        var finalAns = ""
        if var tempAns = currentAnsId{
            finalAns = tempAns
        }
        cell.upvoteHandler = { [weak self] in
            guard let url = URL(string:"http://10.20.4.131:8082/answer/upVoteAnswer/\(finalAns)") else {
                        return
                    }
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "token")
    //                let body: [String: Any] = [
    //
    //
    //
    //
    //                ]
    //                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
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
        cell.devoteHandler = { [weak self] in
            guard let url = URL(string:"http://10.20.4.131:8082/answer/downVoteAnswer/\(finalAns)") else {
                        return
                    }
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "token")
    //                let body: [String: Any] = [
    //
    //
    //
    //
    //                ]
    //                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
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
        
        return cell;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCustomViewInCell()
        self.navigationController?.isNavigationBarHidden = false
        answerCollectionView.delegate = self
        answerCollectionView.dataSource = self
        question.text = questionData
        
        

        // Do any additional setup after loading the view.
    }
    func registerCustomViewInCell(){
        let nib = UINib(nibName: "AnswerDescriptionCollectionViewCell", bundle: nil)
        answerCollectionView.register(nib , forCellWithReuseIdentifier: "AnswerDescriptionIdentifier")
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

    func commentTrigger(answerId:String) {
        DispatchQueue.main.async {
            self.tempAnswerId = answerId
            self.performSegue(withIdentifier: "commentIdentifier", sender: nil)
        }
    }
    

}
