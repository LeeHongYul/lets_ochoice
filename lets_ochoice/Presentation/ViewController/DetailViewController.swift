import UIKit

class DetailViewController: UIViewController {
    
    private let detailViewModel: DetailViewModel
    
    init(id: Int, type: String) {
        self.detailViewModel = DetailViewModel(id: id, type: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        // 데이터 fetch 및 UI 구성
        detailViewModel.fetchContentsGroupInfo(type: detailViewModel.type) { [weak self] in
            DispatchQueue.main.async {
                self?.setupUI()
            }
        }
        
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
        watchButton.backgroundColor = .red
        watchButton.setTitleColor(.white, for: .normal)
        watchButton.layer.cornerRadius = 10
        view.addSubview(watchButton)
        
        // Share Button
        let shareButton = UIButton(type: .system)
        shareButton.setTitle("공유하기", for: .normal)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.backgroundColor = .green
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.layer.cornerRadius = 10
        view.addSubview(shareButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),
            
            contentStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentStackView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            
            shareButton.bottomAnchor.constraint(equalTo: watchButton.topAnchor, constant: -16),
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            
            watchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            watchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            watchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            watchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // UI 업데이트
        titleLabel.text = "Title: \(detailViewModel.contentTitle ?? "N/A")"
        synopsisLabel.text = "Synopsis: \(detailViewModel.synopsis ?? "N/A")"
        actorLabel.text = "Actor: \(detailViewModel.actor ?? "N/A")"
        writerLabel.text = "Writer: \(detailViewModel.writer ?? "N/A")"
        directorLabel.text = "Director: \(detailViewModel.director ?? "N/A")"
        
        if let posterURL = detailViewModel.posterURL, let url = URL(string: posterURL) {
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
        label.textColor = .white
        return label
    }
    
    @objc private func watchButtonTapped() {
        guard let movieUrl = detailViewModel.movieUrl else {
            print("Error: Movie URL is not available")
            return
        }
        
        let playMovieController = PlayMovieController(movieUrl: movieUrl)
        navigationController?.pushViewController(playMovieController, animated: true)
    }
    
    @objc private func shareButtonTapped() {
        guard let movieUrl = detailViewModel.movieUrl else {
            print("Error: Movie URL is not available")
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [movieUrl], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                self.showToast(message: "share success", font: .boldSystemFont(ofSize: 10))
            } else {
                self.showToast(message: "share cancel",  font: .boldSystemFont(ofSize: 10))
            }
            if let shareError = error {
                self.showToast(message: "\(shareError.localizedDescription)",  font: .boldSystemFont(ofSize: 10))
            }
        }
      
        
        present(activityViewController, animated: true, completion: nil)
    }

}



