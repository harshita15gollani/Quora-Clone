//
//  AdsManager.swift
//  Quora
//
//  Created by Harshita Gollani on 10/08/22.
//

import Foundation
import UIKit

protocol AdsManagerDelegate {
    func updateAds(AdsDetail: AdsModel)
}
class AdsManager: UIViewController{
    var delegate: AdsManagerDelegate?
    func fetchAdsList(searchItem: String)
    {
        let urlString = "http://10.20.3.120:8111/ads/getads"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String)
    {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url)
                       request.httpMethod = "GET"
                       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
                                   request.addValue("application/json", forHTTPHeaderField: "Accept")
           
                                   request.addValue(UserDefaults.standard.string(forKey: "token")!, forHTTPHeaderField: "token")
            let task = session.dataTask(with: request){
                [weak self] (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let safeData = data{
                    print("URL: \(urlString) succesful, withData: \(safeData)")
                    if let fetchedData = self?.parseJSON(safeData){
                        self?.delegate?.updateAds(AdsDetail: fetchedData)
                    }
                }
            }
            task.resume()
        } else {
            print("Failed to parse URL String: \(urlString)")
        }
    }
    
    func parseJSON(_ adsData: Data) -> AdsModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(AdsModel.self, from: adsData)
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

