//
//  NewProfileManager.swift
//  Quora
//
//  Created by Harshita Gollani on 12/08/22.
//

import Foundation
import UIKit

protocol NewProfileManagerDelegate {
    func updateData(profileDetail: ProfileModel)
}
class NewProfileManager: UIViewController{
    var delegate: NewProfileManagerDelegate?
    func fetchProductList(searchItem: String)
    {
        let urlString = "http://10.20.4.131:8080/account/viewAccount/\(searchItem)"
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
    
    func parseJSON(_ profileData: Data) -> ProfileModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ProfileModel.self, from: profileData)
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

