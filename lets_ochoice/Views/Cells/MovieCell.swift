import UIKit

class MovieCell: UICollectionViewCell {

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let synopsisLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(synopsisLabel)

        // Auto Layout 제약 설정
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 180),

            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            synopsisLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            synopsisLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            synopsisLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            synopsisLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with movie: Movie) {

        titleLabel.text = movie.title
        titleLabel.textColor = .black
        authorLabel.text = "Directed by \(movie.author)"
        synopsisLabel.text = movie.synopsis
        synopsisLabel.textColor = .lightGray
        
        downloadImage(from: movie.posterImageURL)
    }
    
    private func downloadImage(from urlString: String) {
        // urlString을 URL로 변환
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async { [weak self] in
            do {
                // URL에서 데이터를 비동기적으로 다운로드
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        // 다운로드된 이미지를 메인 스레드에서 UIImageView에 설정
                        self?.posterImageView.image = image
                    }
                }
            } catch {
                print("Image download error: \(error)")
            }
        }
    }

}
