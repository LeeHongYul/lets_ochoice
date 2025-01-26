import UIKit

class DetailViewController: UIViewController {
    private let id: Int
    private var movieUrl: String?
    
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
        setupWatchButton()
        getContentsGroupInfo(id: id)
        
    }
    
    private func setupWatchButton() {
        let watchButton = UIButton(type: .system)
        watchButton.setTitle("시청하기", for: .normal)
        watchButton.addTarget(self, action: #selector(watchButtonTapped), for: .touchUpInside)
        watchButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(watchButton)
        
        // 버튼 위치 설정
        NSLayoutConstraint.activate([
            watchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            watchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            watchButton.widthAnchor.constraint(equalToConstant: 120),
            watchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func watchButtonTapped() {
        guard let movieUrl = movieUrl else {
            print("Error: Movie URL is not available")
            return
        }
        
        // PlayMovieController로 이동
        let playMovieController = PlayMovieController(movieUrl: movieUrl)
        navigationController?.pushViewController(playMovieController, animated: true)
    }
    
    func getMovieUrl(movieUrl: String) -> String {
        // URL의 마지막 슬래시("/") 위치를 찾음
        guard let slashIndex = movieUrl.lastIndex(of: "/") else {
            return movieUrl
        }
        
        // 마지막 슬래시 이전의 부분 문자열 추출
        let subContentStr = String(movieUrl[..<slashIndex])
        
        return "\(subContentStr)/HLS/master.m3u8"
        
    }
    
    private func getContentsGroupInfo(id: Int) {
        // 기본 파라미터 설정
        var parameters: [String: Any] = ["contentGroupId": id]
        
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
                        let originalMovieUrl = content.movieURL
                        self.movieUrl = self.getMovieUrl(movieUrl: originalMovieUrl)
                        print("Modified Movie URL: \(self.movieUrl ?? "N/A")")
                    }
                }
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
}



