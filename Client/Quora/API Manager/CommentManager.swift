//
//  CommentManager.swift
//  Quora
//
//  Created by Harshita Gollani on 10/08/22.
//

import Foundation
import UIKit

protocol CommentManagerDelegate {
    func updateData(profileDetail: CommentModel)
}
class CommentManager: UIViewController{
    var delegate: CommentManagerDelegate?
    func fetchProductList(searchItem: String)
    {
        //\(searchItem)62f0bc72c00b794e86f55f46
        let urlString = "http://10.20.4.131:8082/comment/viewNestedComments/\(searchItem)"
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
                        self?.delegate?.updateData(profileDetail: fetchedData)
                    }
                }
            }
            task.resume()
        } else {
            print("Failed to parse URL String: \(urlString)")
        }
    }
    
    func parseJSON(_ profileData: Data) -> CommentModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CommentModel.self, from: profileData)
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

