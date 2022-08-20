//
//  AnswerViewController.swift
//  Quora
//
//  Created by Harshita Gollani on 05/08/22.
//

import UIKit

class AnswerViewController: UIViewController {

    
    @IBOutlet weak var post: UIButton!
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var myAnswerId:String?
    @IBAction func post(_ sender: Any) {
        var ans = ""
        if var temp = answer.text{
            ans = temp
        }
        var lastAns = ""
        if var tempAns = myAnswerId{
            lastAns = tempAns
        }
        guard let url = URL(string: "http://10.20.4.131:8082/answer/addAnswer/62f0b97e8c8ca2093f142979") else {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("answer :\(answer.text)")
        
                let body: [String: Any] = [
        
                    "answerDescription": ans,
                        "codeEmbed":"fhf",
                        "urlEmbed":"gnvn",
                        "accountId":"62f0b97e8c8ca2093f142979",
                        "numberOfUpvotes":1,
                        "numberOfDownvotes":0,
                        "accepted":true,
                        "questionId":"\(lastAns)"


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
    
    
    @IBOutlet weak var answer: UITextView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        post.layer.cornerRadius = 10.0
        
        // Do any additional setup after loading the view.
    }
    

}
