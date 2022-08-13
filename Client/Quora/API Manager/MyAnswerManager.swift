//
//  MyAnswerManager.swift
//  Quora
//
//  Created by Harshita Gollani on 09/08/22.
//

import Foundation
import UIKit
protocol MyAnswerManagerDelegate {
    func updateData(answerDetail: [AnswerModel])
}
class MyAnswerManager: UIViewController {
    var delegate: MyAnswerManagerDelegate?
    func fetchProductList(searchItem: String)
    {
        let urlString = "http://10.20.4.131:8082/posts/myPost/62f0b97e8c8ca2093f142979"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String)
    {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){
                [weak self] (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let safeData = data{
                    print("URL: \(urlString) succesful, withData: \(safeData)")
                    if let fetchedData = self?.parseJSON(safeData){
                        self?.delegate?.updateData(answerDetail: fetchedData)
                    }
                }
            }
            task.resume()
        } else {
            print("Failed to parse URL String: \(urlString)")
        }
    }
    
    func parseJSON(_ answerData: Data) -> [AnswerModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([AnswerModel].self, from: answerData)
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

