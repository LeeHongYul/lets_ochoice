import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private var categoryLists: [CategoryList] = []

    private lazy var collectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        collectionView.register(CategoryItemCell.self, forCellWithReuseIdentifier: CategoryItemCell.identifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        if let terminalKey = TerminalKeyManager.shared.getTerminalKey() {
            let parameters = ["terminalKey": terminalKey]
            getMainList(parameters: parameters)
        } else {
            print("Error: Terminal key not found in UserDefaults")
        }
    }

    private func getMainList(parameters: [String: String]) {
        var urlComponents = URLComponents(string: APIManager.shared.baseMBSURL + "/mainCategoryList")
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = urlComponents?.url else {
            print("Invalid URL with parameters")
            return
        }
        
        NetworkManager.shared.fetchData(from: url, parameters: parameters) { (result: Result<MainCategoryList, Error>) in
            switch result {
            case .success(let data):
                print("Data received: \(data)")
                self.categoryLists = data.categoryList
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }

    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categoryLists.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryLists[section].categoryItemList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryItemCell.identifier, for: indexPath) as! CategoryItemCell
        let item = categoryLists[indexPath.section].categoryItemList[indexPath.item]
        cell.configure(with: item.posterURL)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
            header.configure(with: categoryLists[indexPath.section].title)
            return header
        }
        return UICollectionReusableView()
    }
    
    // MARK: UICollectionViewDelegate

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            
            // Navigate to a detail screen or perform an action
            let selectedItem = categoryLists[indexPath.section].categoryItemList[indexPath.item]
            print("Selected item: \(selectedItem.id)")
            
               let detailViewController = DetailViewController(id: selectedItem.id)
               navigationController?.pushViewController(detailViewController, animated: true)
        }
    
    
    // MARK: Compositional Layout

    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            // Get the category for the section
            let category = self.categoryLists[sectionIndex]
            
            // Item size adjustment for the specific category with id 1089
            let isSpecialCategory = category.id == 1089
            let itemWidth: CGFloat = isSpecialCategory ? 300 : 100 // Larger width for special category
            let itemHeight: CGFloat = isSpecialCategory ? 300 : 150 // Height for special category

            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth), heightDimension: .absolute(itemHeight))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            // Group size based on the item size
            let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(500), heightDimension: .absolute(itemHeight))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            // Section configuration
            let section = NSCollectionLayoutSection(group: group)
            
            if isSpecialCategory {
                // Enable horizontal scrolling for the special category, displaying one item at a time
                section.orthogonalScrollingBehavior = .continuous
            } else {
                section.orthogonalScrollingBehavior = .continuous // Enable horizontal scroll for other categories
            }
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            // Header configuration
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]

            return section
        }
    }

}

