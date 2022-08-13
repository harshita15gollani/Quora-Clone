//
//  SearchModel.swift
//  Quora
//
//  Created by Harshita Gollani on 10/08/22.
//

import Foundation
struct SearchModel: Codable{
        let id: String?
        let profileImage: String?
        let userName, description, gender: String?
        let score: Int?
        let accountType: String?
        let noOfFollowers, noOfFollowing: Int?
}
