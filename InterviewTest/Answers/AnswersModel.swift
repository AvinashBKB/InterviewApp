//
//  AnswersModel.swift
//  InterviewTest
//
//  Created by Avinash Boora on 2/5/21.
//

import Foundation

// MARK: - Answers
struct Answers: Codable {
    let items: [AnswerItem]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int

    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.itemTask(with: url) { item, response, error in
//     if let item = item {
//       ...
//     }
//   }
//   task.resume()

// MARK: - AnswerItem
struct AnswerItem: Codable {
    let owner: AnswerOwner
    let isAccepted: Bool
    let score, lastActivityDate, creationDate, answerID: Int
    let questionID: Int
    let contentLicense: AnswerContentLicense
    let lastEditDate: Int?

    enum CodingKeys: String, CodingKey {
        case owner
        case isAccepted = "is_accepted"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case answerID = "answer_id"
        case questionID = "question_id"
        case contentLicense = "content_license"
        case lastEditDate = "last_edit_date"
    }
}

enum AnswerContentLicense: String, Codable {
    case ccBySa30 = "CC BY-SA 3.0"
    case ccBySa40 = "CC BY-SA 4.0"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.ownerTask(with: url) { owner, response, error in
//     if let owner = owner {
//       ...
//     }
//   }
//   task.resume()

// MARK: - AnswerOwner
struct AnswerOwner: Codable {
    let reputation, userID: Int
    let userType: UserType
    let profileImage: String
    let displayName: String
    let link: String
    let acceptRate: Int?

    enum CodingKeys: String, CodingKey {
        case reputation
        case userID = "user_id"
        case userType = "user_type"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
        case acceptRate = "accept_rate"
    }
}


// MARK: - Helper functions for creating encoders and decoders

func AnswerJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func AnswerJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
