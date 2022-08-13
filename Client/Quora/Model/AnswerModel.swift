//
//  AnswerModel.swift
//  Quora
//
//  Created by Harshita Gollani on 08/08/22.
//

import Foundation
struct AnswerModel: Codable {
    let description, codeEmbed, urlEmbed, accountId: String?
    let numberOfUpvotes, numberOfDownvotes: Int?
    let alive: Bool?
    let profileImage: String?
    let userName, questionId, category: String?
    let answersList: [AnswersList]?
   
}

struct AnswersList: Codable {
    let questionId, accountId, answerId: String?
    //let answerId: JSONNull?
    let numberOfUpvotes, numberOfDownvotes: Int?
    let codeEmbed, urlEmbed: String?
    let accepted: Bool?
    let profileImage: String?
    let userName: String?
    let commentsLevel: [CommentsLevel]?
    let answerDescription: String?

    
}

struct CommentsLevel: Codable {
    let accountId, parentId, answerId, commentId: String?
   // let answerId: JSONNull?
    let level: Int?
    let commentText, codeEmbed, urlEmbed: String?
   // let nestedComments: JSONNull?
    let profileImage: String?
    let userName: String?
   
}



