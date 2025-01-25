import Foundation

class NetworkManager {
    static let shared = NetworkManager()
   
    private let session = URLSession(configuration: .default)

    private init() {}

    // 제너릭 타입을 사용하여 Codable로 디코딩할 수 있는 fetchData
    func fetchData<T: Codable>(from url: URL, parameters: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        // 터미널 키 자동 추가
        if let terminalKey = TerminalKeyManager.shared.getTerminalKey() {
            var updatedParameters = parameters
            updatedParameters["terminalKey"] = terminalKey
            // 쿼리 파라미터 추가
            urlComponents?.queryItems = updatedParameters.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        } else {
            completion(.failure(NSError(domain: "Terminal key not found", code: 401, userInfo: nil)))
            return
        }

        guard let finalUrl = urlComponents?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: finalUrl) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    // `Any` 타입을 반환하는 메서드
    func fetchAnyData(from url: URL, completion: @escaping (Result<Any, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

