//
//  SearchManager.swift
//  Quora
//
//  Created by Harshita Gollani on 10/08/22.
//

import Foundation
import UIKit

protocol SearchManagerDelegate {
    func updateData(productDetail: [SearchModel])
}

class SearchManager: UIViewController {
    var delegate: SearchManagerDelegate?
    
    func fetchProductList(searchItem: String)
    {
        let urlString = "http://10.20.4.96:9090/search/findall/\(searchItem)"
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
                        self?.delegate?.updateData(productDetail: fetchedData)
                    }
                }
            }
            task.resume()
        } else {
            print("Failed to parse URL String: \(urlString)")
        }
    }
    
    func parseJSON(_ productData: Data) -> [SearchModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([SearchModel].self, from: productData)
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
