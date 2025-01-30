import Foundation

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
