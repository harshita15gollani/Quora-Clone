//
//  ProfileModel.swift
//  Quora
//
//  Created by Harshita Gollani on 07/08/22.
//

import Foundation

struct ProfileModel: Codable {
    let id, userName, email, description: String?
        let phoneNumber: String?
        let score: Int?
        let password, scoreBatch: String?
        let profileImage: String?
        let gender, accountType: String?
        let noOfFollowers, noOfFollowing: Int?
        let followers, following: [Follow]?
}
struct Follow: Codable {
    let id, userName: String?
    let profileImage: String?
}
