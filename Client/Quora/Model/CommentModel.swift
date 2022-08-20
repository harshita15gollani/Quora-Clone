//
//  CommentModel.swift
//  Quora
//
//  Created by Harshita Gollani on 10/08/22.
//

import Foundation


struct CommentModel: Codable {
    let id: String?  
    let questionId: String?
    let accountId: String?
    let answerDescription: String?
    let numberOfUpvotes, numberOfDownvotes: Int?
   
    let accepted: Bool?
    let nestedComment: [NestedComment]?

    
}



// MARK: - NestedComment
struct NestedComment: Codable {
    let accountId: String?
    let parentId: String?
    let answerId: String?
    let level: Int?
    let userName: String?
    let profileImage:String?
    let commentText: String?
    let id: String?
    let nestedComment: [NestedComment]?

    
}


