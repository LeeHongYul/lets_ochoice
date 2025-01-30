import Foundation

class DetailViewModel {
    let id: Int
    let type: String
    var movieUrl: String?
    var contentTitle, synopsis, actor, writer, director, posterURL: String?
    
    init(id: Int, type: String) {
        self.id = id
        self.type = type
    }
    
    func fetchContentsGroupInfo(type: String, completion: @escaping () -> Void) {
        var parameters: [String: Any]
        var urlString: String
        
        
        if type == "contentGroup" {
            parameters = ["contentGroupId": id]
            urlString = APIManager.shared.baseMBSURL + "/v3/contentGroup"
            
            guard var urlComponents = URLComponents(string: urlString) else {
                print("Error: Invalid base URL")
                return
            }
            
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            
            guard let url = urlComponents.url else {
                print("Error: Invalid full URL")
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
        } else {
            print("Qweqwe \(id)")
            parameters = ["pageSize": 10, "pageNo": 1, "seriesId": id]
            urlString = APIManager.shared.baseMBSURL + "/v3/series"
            
            guard var urlComponents = URLComponents(string: urlString) else {
                print("Error: Invalid base URL")
                return
            }
            
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            
            guard let url = urlComponents.url else {
                print("Error: Invalid full URL")
                return
            }
            
           
            
            NetworkManager.shared.fetchData(from: url, parameters: parameters) { (result: Result<SeriesModel, Error>) in
                print("RWWWWW \(result)")
                switch result {
        
                case .success(let seriesModel):
                    print("enter is is ")
                    if let offer = seriesModel.series.contentList.first {
                        print("OFFFER IS \(offer)")
                        self.movieUrl = self.modifyMovieUrl(offer.movieURL)
                        self.contentTitle = offer.title
                        self.synopsis = offer.synopsis
                        self.actor = offer.actor
                        self.writer = offer.writer
                        self.director = offer.director
                        self.posterURL = offer.posterURL
                    }
                        completion()
                    
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                }
            }
        }
        
        
    }
    
    private func modifyMovieUrl(_ originalUrl: String) -> String {
        guard let slashIndex = originalUrl.lastIndex(of: "/") else { return originalUrl }
        let subContentStr = String(originalUrl[..<slashIndex])
        return "\(subContentStr)/HLS/master.m3u8"
    }
}

