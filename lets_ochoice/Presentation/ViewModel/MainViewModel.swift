import Foundation

class MainViewModel {
    private(set) var categoryLists: [CategoryList] = []
    var onDataUpdated: (() -> Void)?
    var onErrorOccurred: ((String) -> Void)?

    func fetchMainList() {
        guard let url = URL(string: APIManager.shared.baseMBSURL + "/mainCategoryList") else {
            onErrorOccurred?("Invalid base URL")
            return
        }
        
        NetworkManager.shared.fetchData(from: url, parameters: [:]) { [weak self] (result: Result<MainCategoryList, Error>) in
            switch result {
            case .success(let data):
                self?.categoryLists = data.categoryList
                self?.onDataUpdated?()
            case .failure(let error):
                self?.onErrorOccurred?(error.localizedDescription)
            }
        }
    }
}

