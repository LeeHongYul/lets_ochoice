import UIKit

class DetailViewController: UIViewController {
    
    private let id: Int

    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Received ID: \(id)")
        getContentsGroupInfo(id: id)
       
    }
    
    private func getContentsGroupInfo(id: Int) {
        // 기본 파라미터 설정
        var parameters: [String: Any] = ["contentGroupId": id]
        
        // 터미널 키 자동 추가
        if let terminalKey = TerminalKeyManager.shared.getTerminalKey() {
            parameters["terminalKey"] = terminalKey
        } else {
            print("Error: Terminal key not found")
            return
        }

        // URL 생성
        var urlComponents = URLComponents(string: APIManager.shared.baseMBSURL + "/v3/contentGroup")!
        
        // 쿼리 파라미터 추가
        urlComponents.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }

        guard let url = urlComponents.url else {
            print("Error: Invalid URL")
            return
        }

        // 네트워크 요청
            NetworkManager.shared.fetchData(from: url, parameters: parameters) { (result: Result<ContentGroupModel, Error>) in
                switch result {
                case .success(let contentGroupModel):
                    // ContentGroupModel -> ContentGroup -> ContentList
                           for offer in contentGroupModel.contentGroup.offerContentList {
                               for content in offer.contentList ?? [] {
                                   print("Movie URL: \(content.movieURL)")
                               }
                           }
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                }
            }    }

    
//    private func getSeriesInfo(parameters: [String: Any]) {
//        // URL 구성
//        var urlComponents = URLComponents(string: APIManager.shared.baseMBSURL + "/v3/series")
//        
//        // 쿼리 파라미터 추가
//        urlComponents?.queryItems = parameters.map { key, value in
//            URLQueryItem(name: key, value: "\(value)")
//        }
//
//        // URL 검증
//        guard let url = urlComponents?.url else {
//            print("Invalid URL with parameters")
//            return
//        }
//
//        // 네트워크 요청
//        NetworkManager.shared.fetchData(from: url) { result in
//            switch result {
//            case .success(let jsonData):
//                if let json = jsonData as? [String: Any] {
//                    print("Dynamic JSON data: \(json)")
//                } else {
//                    print("Unexpected data format")
//                }
//            case .failure(let error):
//                print("Error fetching data: \(error.localizedDescription)")
//            }
//        }
//    }
}



