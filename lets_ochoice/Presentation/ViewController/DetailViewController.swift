import UIKit

class DetailViewController: UIViewController {
    private let id: Int
    private var movieUrl: String?
    
    private var contentTitle, synopsis, actor, writer, director, posterURL: String?
    
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
    
    private func setupUI() {
        // Poster ImageView
        let posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.backgroundColor = .lightGray
        view.addSubview(posterImageView)
        
        // Content StackView
        let contentStackView = UIStackView()
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.alignment = .leading
        contentStackView.spacing = 12
        contentStackView.setContentHuggingPriority(.defaultLow, for: .vertical)
        contentStackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        contentStackView.distribution = .fill
        view.addSubview(contentStackView)
        
        // Labels for content details
        let titleLabel = createLabel(fontSize: 18, fontWeight: .bold)
        let synopsisLabel = createLabel(fontSize: 14, fontWeight: .regular)
        let actorLabel = createLabel(fontSize: 14, fontWeight: .regular)
        let writerLabel = createLabel(fontSize: 14, fontWeight: .regular)
        let directorLabel = createLabel(fontSize: 14, fontWeight: .regular)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(synopsisLabel)
        contentStackView.addArrangedSubview(actorLabel)
        contentStackView.addArrangedSubview(writerLabel)
        contentStackView.addArrangedSubview(directorLabel)
        
        // Watch Button
        let watchButton = UIButton(type: .system)
        watchButton.setTitle("시청하기", for: .normal)
        watchButton.addTarget(self, action: #selector(watchButtonTapped), for: .touchUpInside)
        watchButton.translatesAutoresizingMaskIntoConstraints = false
        watchButton.backgroundColor = .systemBlue
        watchButton.setTitleColor(.white, for: .normal)
        watchButton.layer.cornerRadius = 10
        view.addSubview(watchButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            // Poster ImageView Constraints
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),
            
            // Content StackView Constraints
            contentStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentStackView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            
            
            // Watch Button Constraints
            watchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            watchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            watchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            watchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            watchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Assign content to labels (mock data for now)
        titleLabel.text = "Title: \(contentTitle ?? "N/A")"
        synopsisLabel.text = "Synopsis: \(synopsis ?? "N/A")"
        actorLabel.text = "Actor: \(actor ?? "N/A")"
        writerLabel.text = "Writer: \(writer ?? "N/A")"
        directorLabel.text = "Director: \(director ?? "N/A")"
        
        // Mock image for poster
        if let posterURL = posterURL, let url = URL(string: posterURL) {
            // Load image asynchronously (you can use libraries like SDWebImage for this)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        posterImageView.image = image
                    }
                }
            }
        }
    }
    
    private func createLabel(fontSize: CGFloat, fontWeight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
         
        return label
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
                        self.contentTitle = content.title
                        self.synopsis = content.synopsis
                        self.actor = content.actor
                        self.writer = content.writer
                        self.director = content.director
                        self.posterURL = content.posterURL
                    }
                }
                DispatchQueue.main.async {
                    self.setupUI()  // Re-render the UI with the fetched data
                }
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
}



