//
//  CreatePostController.swift
//  Quora
//
//  Created by Harshita Gollani on 04/08/22.
//

import UIKit

class CreatePostController: UIViewController {

    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var post: UIButton!
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var postQuestion: UITextView!
    
    @IBAction func post(_ sender: Any) {
        guard let url = URL(string:"http://10.20.4.131:8082/question/addQuestion/62f0b97e8c8ca2093f142979") else {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "token")
                let body: [String: Any] = [

                    "description":postQuestion.text,
                       "codeEmbed":"fhf",
                       "urlEmbed":"gnvn",
                       "accountId":"ghxz",
                       "numberOfUpvotes":1,
                       "numberOfDownvotes":0,
                       "alive":true,
                       "category":"sports",
                       "questionId":"a1"

                ]
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
               
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
    override func viewDidLoad() {
        super.viewDidLoad()
        post.layer.cornerRadius = 10.0
        // Do any additional setup after loading the view.
    }
    

   
}
