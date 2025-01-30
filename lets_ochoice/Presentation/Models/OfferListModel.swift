import Foundation

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
