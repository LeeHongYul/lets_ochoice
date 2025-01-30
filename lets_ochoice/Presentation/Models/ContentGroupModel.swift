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

// MARK: - OfferList
struct OfferList: Codable {
    let id: Int
    let title: String
    let posterURL: String?
    let packageType, productType: String
    let price, discountPrice: Int
    let rentalPeriod, eventType: String
    let isPurchase: Bool
    let viewablePeriod: String
 
    let pointPolicyType: String
    let pointPolicyValue: Int
    let contentList: [ContentList]?
    let adult: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title
        case posterURL = "posterUrl"
        case packageType, productType, price, discountPrice, rentalPeriod, eventType, isPurchase, viewablePeriod
       
        case pointPolicyType, pointPolicyValue, contentList, adult
    }
}


// MARK: - ContentList
struct ContentList: Codable {
    let id, contentGroupID: Int
    let seriesID: Int?
    let title: String
    let posterURL: String
    let synopsis, actor, writer, director: String
    let releaseYear, genre, rating: String
    let episodeNo: Int
    let isAdult, isWish: Bool
    let reviewRating: Int
    let runTimeDisplay, runTime: String
    let movieURL: String
    let thumbnailURL: String
    let thumbnailServerInfo: String
    let trailerURL: String
    let previewDurationInSEC: Int
    let isHot, isNew: Bool
    let translationType: String
    let isAudioVisual: Bool
    let advURL: String
    let offerList: [OfferList]
   
    let openingStartTime, openingEndTime, closingTime: Int
    let thumbnailPosterOld, thumbnailPosterNew: String
  

    enum CodingKeys: String, CodingKey {
        case id
        case contentGroupID = "contentGroupId"
        case seriesID = "seriesId"
        case title
        case posterURL = "posterUrl"
        case synopsis, actor, writer, director, releaseYear, genre, rating, episodeNo, isAdult, isWish, reviewRating, runTimeDisplay, runTime
        case movieURL = "movieUrl"
        case thumbnailURL = "thumbnailUrl"
        case thumbnailServerInfo
        case trailerURL = "trailerUrl"
        case previewDurationInSEC = "previewDurationInSec"
        case isHot, isNew, translationType, isAudioVisual
        case advURL = "advUrl"
        case offerList, openingStartTime, openingEndTime, closingTime, thumbnailPosterOld, thumbnailPosterNew
    }
}

