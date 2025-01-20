//
//  TerminalKeyManager 2.swift
//  lets_ochoice
//
//  Created by homechoic on 1/19/25.
//


import Foundation

final class TerminalKeyManager {
    static let shared = TerminalKeyManager()
    private init() {}

    private let terminalKeyKey = "terminalKey"
    private let userDefaults = UserDefaults.standard

    /// 앱 실행 시 terminalKey를 가져오는 메서드
    func fetchTerminalKey(deviceId: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: APIManager.shared.baseMBSURL + "/session-auth") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        let payload: [String: Any] = [
            "appCode": "mobile.homechoice.co.kr",
            "deviceType": "MOBILE.ios",
            "deviceId": "D0A92F40-874F-4B41-87A2-AA9A531C18BF"
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let terminalKey = json["terminalKey"] as? String else {
                completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
                return
            }

            self.saveTerminalKey(terminalKey)
            completion(.success(terminalKey))
        }
        task.resume()
    }

    /// TerminalKey를 UserDefaults에 저장
    private func saveTerminalKey(_ terminalKey: String) {
        userDefaults.set(terminalKey, forKey: terminalKeyKey)
    }

    /// TerminalKey를 UserDefaults에서 가져오기
    func getTerminalKey() -> String? {
        print("Key:" + userDefaults.string(forKey: terminalKeyKey)!)
        return userDefaults.string(forKey: terminalKeyKey)
    }
    
    /// TerminalKey를 UserDefaults에서 지우기
    func clearTerminalKey() {
          userDefaults.removeObject(forKey: terminalKeyKey)
      }
}
