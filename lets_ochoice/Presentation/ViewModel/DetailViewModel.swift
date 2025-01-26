import Foundation

class DetailViewModel {
    let id: Int
    var movieUrl: String?
    var contentTitle, synopsis, actor, writer, director, posterURL: String?
    
    init(id: Int) {
        self.id = id
    }
    
    func fetchContentsGroupInfo(completion: @escaping () -> Void) {
        let parameters: [String: Any] = ["contentGroupId": id]
        var urlComponents = URLComponents(string: APIManager.shared.baseMBSURL + "/v3/contentGroup")!
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        guard let url = urlComponents.url else {
            print("Error: Invalid URL")
            return
        }
        
        NetworkManager.shared.fetchData(from: url, parameters: parameters) { (result: Result<ContentGroupModel, Error>) in
            switch result {
            case .success(let contentGroupModel):
                if let offer = contentGroupModel.contentGroup.offerContentList.first,
                   let content = offer.contentList?.first {
                    self.movieUrl = self.modifyMovieUrl(content.movieURL)
                    self.contentTitle = content.title
                    self.synopsis = content.synopsis
                    self.actor = content.actor
                    self.writer = content.writer
                    self.director = content.director
                    self.posterURL = content.posterURL
                }
                completion()
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    private func modifyMovieUrl(_ originalUrl: String) -> String {
        guard let slashIndex = originalUrl.lastIndex(of: "/") else { return originalUrl }
        let subContentStr = String(originalUrl[..<slashIndex])
        return "\(subContentStr)/HLS/master.m3u8"
    }
}

