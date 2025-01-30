import Foundation

// MARK: - SeriesModel
struct SeriesModel: Codable {
    let transactionId, errorString, sessionState, dliveterminalKey: String
    let cardName: String
    let series: Series
    
    enum CodingKeys: String, CodingKey {
        case transactionId
        case errorString, sessionState, dliveterminalKey, cardName, series
    }
}

// MARK: - Series
struct Series: Codable {
    let id: Int
    let posterUrl: String
    let contentList: [ContentList]
//    let advUrL: String
//    let episodeNoList: [Int]
//    let latestWatchedContentId, lasWatchedEpisode: Int
  
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterUrl
        case contentList
//        case advUrL
//        case episodeNoList
//        case latestWatchedContentId
//        case lasWatchedEpisode
    }
}



