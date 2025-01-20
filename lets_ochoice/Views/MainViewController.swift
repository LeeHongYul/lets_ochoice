import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private let collectionMovieData: [[Movie]] = [
        [
            Movie(title: "Inception", author: "Christopher Nolan", synopsis: "A mind-bending thriller that delves into the world of dreams.", posterImageURL: "https://i3n.news1.kr/system/photos/2024/7/16/6760884/high.jpg"),
            Movie(title: "The Dark Knight", author: "Christopher Nolan", synopsis: "Batman faces off against the Joker in this action-packed thriller.", posterImageURL: "https://i3n.news1.kr/system/photos/2024/7/16/6760884/high.jpg"),
            Movie(title: "The Matrix", author: "The Wachowskis", synopsis: "A computer hacker learns about the true nature of reality.", posterImageURL: "https://i3n.news1.kr/system/photos/2024/7/16/6760884/high.jpg"),
        ],
        [
            Movie(title: "Inception", author: "Christopher Nolan", synopsis: "A mind-bending thriller that delves into the world of dreams.", posterImageURL: "https://i.namu.wiki/i/fmZQW-RR1jTR8sdWxOwme65a5C5gUx1srEI2ENCQ-LhGoNJYdo7Sv_3UvR8bidenVsIjS_3dA6CC9Vx3AQdA-Q.webp"),
            Movie(title: "The Dark Knight", author: "Christopher Nolan", synopsis: "Batman faces off against the Joker in this action-packed thriller.", posterImageURL: "https://i.namu.wiki/i/fmZQW-RR1jTR8sdWxOwme65a5C5gUx1srEI2ENCQ-LhGoNJYdo7Sv_3UvR8bidenVsIjS_3dA6CC9Vx3AQdA-Q.webp"),
            Movie(title: "The Matrix", author: "The Wachowskis", synopsis: "A computer hacker learns about the true nature of reality.", posterImageURL: "https://i.namu.wiki/i/fmZQW-RR1jTR8sdWxOwme65a5C5gUx1srEI2ENCQ-LhGoNJYdo7Sv_3UvR8bidenVsIjS_3dA6CC9Vx3AQdA-Q.webp"),
            Movie(title: "Inception", author: "Christopher Nolan", synopsis: "A mind-bending thriller that delves into the world of dreams.", posterImageURL: "https://i.namu.wiki/i/fmZQW-RR1jTR8sdWxOwme65a5C5gUx1srEI2ENCQ-LhGoNJYdo7Sv_3UvR8bidenVsIjS_3dA6CC9Vx3AQdA-Q.webp"),
            Movie(title: "The Dark Knight", author: "Christopher Nolan", synopsis: "Batman faces off against the Joker in this action-packed thriller.", posterImageURL: "https://i.namu.wiki/i/fmZQW-RR1jTR8sdWxOwme65a5C5gUx1srEI2ENCQ-LhGoNJYdo7Sv_3UvR8bidenVsIjS_3dA6CC9Vx3AQdA-Q.webp"),
            Movie(title: "The Matrix", author: "The Wachowskis", synopsis: "A computer hacker learns about the true nature of reality.", posterImageURL: "https://i.namu.wiki/i/fmZQW-RR1jTR8sdWxOwme65a5C5gUx1srEI2ENCQ-LhGoNJYdo7Sv_3UvR8bidenVsIjS_3dA6CC9Vx3AQdA-Q.webp"),
            Movie(title: "Inception", author: "Christopher Nolan", synopsis: "A mind-bending thriller that delves into the world of dreams.", posterImageURL: "https://i.namu.wiki/i/fmZQW-RR1jTR8sdWxOwme65a5C5gUx1srEI2ENCQ-LhGoNJYdo7Sv_3UvR8bidenVsIjS_3dA6CC9Vx3AQdA-Q.webp"),
            Movie(title: "The Dark Knight", author: "Christopher Nolan", synopsis: "Batman faces off against the Joker in this action-packed thriller.", posterImageURL: "https://i.namu.wiki/i/fmZQW-RR1jTR8sdWxOwme65a5C5gUx1srEI2ENCQ-LhGoNJYdo7Sv_3UvR8bidenVsIjS_3dA6CC9Vx3AQdA-Q.webp"),
            Movie(title: "The Matrix", author: "The Wachowskis", synopsis: "A computer hacker learns about the true nature of reality.", posterImageURL: "https://i.namu.wiki/i/fmZQW-RR1jTR8sdWxOwme65a5C5gUx1srEI2ENCQ-LhGoNJYdo7Sv_3UvR8bidenVsIjS_3dA6CC9Vx3AQdA-Q.webp"),
        ],
        [
            Movie(title: "Inception", author: "Christopher Nolan", synopsis: "A mind-bending thriller that delves into the world of dreams.", posterImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_l6lJXe-wH6vJXLjUjWvzGUiCX0V4Uf0Z1Q&s"),
            Movie(title: "The Dark Knight", author: "Christopher Nolan", synopsis: "Batman faces off against the Joker in this action-packed thriller.", posterImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_l6lJXe-wH6vJXLjUjWvzGUiCX0V4Uf0Z1Q&s"),
            Movie(title: "The Matrix", author: "The Wachowskis", synopsis: "A computer hacker learns about the true nature of reality.", posterImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_l6lJXe-wH6vJXLjUjWvzGUiCX0V4Uf0Z1Q&s"),
            Movie(title: "Inception", author: "Christopher Nolan", synopsis: "A mind-bending thriller that delves into the world of dreams.", posterImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_l6lJXe-wH6vJXLjUjWvzGUiCX0V4Uf0Z1Q&s"),
            Movie(title: "The Dark Knight", author: "Christopher Nolan", synopsis: "Batman faces off against the Joker in this action-packed thriller.", posterImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_l6lJXe-wH6vJXLjUjWvzGUiCX0V4Uf0Z1Q&s"),
            Movie(title: "The Matrix", author: "The Wachowskis", synopsis: "A computer hacker learns about the true nature of reality.", posterImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_l6lJXe-wH6vJXLjUjWvzGUiCX0V4Uf0Z1Q&s"),
            Movie(title: "Inception", author: "Christopher Nolan", synopsis: "A mind-bending thriller that delves into the world of dreams.", posterImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_l6lJXe-wH6vJXLjUjWvzGUiCX0V4Uf0Z1Q&s"),
            Movie(title: "The Dark Knight", author: "Christopher Nolan", synopsis: "Batman faces off against the Joker in this action-packed thriller.", posterImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_l6lJXe-wH6vJXLjUjWvzGUiCX0V4Uf0Z1Q&s"),
            Movie(title: "The Matrix", author: "The Wachowskis", synopsis: "A computer hacker learns about the true nature of reality.", posterImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_l6lJXe-wH6vJXLjUjWvzGUiCX0V4Uf0Z1Q&s"),
        ]
    ]
    
    
        
  
    

    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        
        if let terminalKey = TerminalKeyManager.shared.getTerminalKey() {
               let parameters = [
                   "terminalKey": terminalKey
               ]
               getMainList(parameters: parameters)
           } else {
               print("Error: Terminal key not found in UserDefaults")
           }

        
       
        
    }
    
    //getMainList(parameters: parameters)
    
    private func getMainList(parameters: [String: String]) {
        // URLComponents를 사용하여 쿼리 파라미터 추가
        var urlComponents = URLComponents(string: APIManager.shared.baseMBSURL + "/mainCategoryList")
        
        urlComponents?.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        // 완성된 URL 생성
        guard let url = urlComponents?.url else {
            print("Invalid URL with parameters")
            return
        }
        
        // 데이터 요청
        NetworkManager.shared.fetchData(from: url) { (result: Result<MainCategoryList, Error>) in
            switch result {
            case .success(let data):
                print("Data received: \(data)")
                // JSON 데이터에 맞는 로직 처리
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }



    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // Vertical scroll for sections
        layout.minimumLineSpacing = 20       // Section vertical spacing
        layout.minimumInteritemSpacing = 10  // Horizontal spacing between items
        
        let itemWidth = 100
        layout.itemSize = CGSize(width: itemWidth, height: 120) // Cell size settings
        layout.collectionView?.backgroundColor = .red
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .brown
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "movieCell")
        view.addSubview(collectionView)

        // CollectionView constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionMovieData.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionMovieData[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = collectionMovieData[indexPath.section][indexPath.item]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.setup(with: movie)

        return cell
    }
}

