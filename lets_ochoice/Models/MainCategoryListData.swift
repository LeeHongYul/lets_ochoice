import Foundation

// MARK: - MainCategoryList
struct MainCategoryList: Codable {
    let transactionID: String
    let errorString: String
    let sessionState: String
    let dliveterminalKey: String
//    let categoryList: [CategoryList]

    enum CodingKeys: String, CodingKey {
        case transactionID = "transactionId"
        case errorString
        case sessionState
        case dliveterminalKey
//        case categoryList
    }
}

//// MARK: - CategoryList
//struct CategoryList: Codable {
//    let id: Int
//    let title: String
//    let categoryItemList: [CategoryItemList]
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case title
//        case categoryItemList
//    }
//}

//// MARK: - CategoryItemList
//struct CategoryItemList: Codable {
//    let id: Int
//    let title: String
//    let type: String
//    let posterURL: String
//    let isAdult: Bool
//    let isFree: Bool
//    let isPurchased: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case title
//        case type
//        case posterURL = "posterUrl"
//        case isAdult
//        case isFree
//        case isPurchased
//    }
//}

