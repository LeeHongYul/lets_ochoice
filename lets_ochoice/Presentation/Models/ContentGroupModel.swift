//
//  ContentGroupModel.swift
//  lets_ochoice
//
//  Created by homechoic on 1/25/25.
//

import Foundation

// MARK: - ContentGroupModel
struct ContentGroupModel: Codable {
    let transactionID, errorString, sessionState, dliveterminalKey: String
    let cardName: String
    let contentGroup: ContentGroup

    enum CodingKeys: String, CodingKey {
        case transactionID = "transactionId"
        case errorString, sessionState, dliveterminalKey, cardName, contentGroup
    }
}

// MARK: - ContentGroup
struct ContentGroup: Codable {
    let id: Int
    let title: String
    let previewURL: String
    let previewDurationInSEC: Int
    let advURL: String
    let offerContentList: [OfferList]
 
    enum CodingKeys: String, CodingKey {
        case id, title
        case previewURL = "previewUrl"
        case previewDurationInSEC = "previewDurationInSec"
        case advURL = "advUrl"
        case offerContentList
    }
}

