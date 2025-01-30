//
//  AppDelegate.swift
//  lets_ochoice
//
//  Created by homechoic on 1/13/25.
//

import UIKit
import FirebaseCore
import FirebaseRemoteConfig

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            window = UIWindow(frame: UIScreen.main.bounds)
            
            // Firebase 연동
            FirebaseApp.configure()

            // singleton을 얻어서 세팅
            let remoteConfig = RemoteConfig.remoteConfig()
            let settings = RemoteConfigSettings()

            // fetchInterval 값 설정: https://firebase.google.com/docs/remote-config/get-started?platform=ios&hl=ko#throttling
            settings.minimumFetchInterval = 0
            remoteConfig.configSettings = settings
            
            // RemoteConfig 값 가져오기
            remoteConfig.fetchAndActivate { status, error in
                if status != .error {
                    if let jsonString = remoteConfig["Config"].stringValue as String? {
                        if let data = jsonString.data(using: .utf8) {
                            do {
                                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                                if let ios = json?["ios"] as? [String: Any] {
                                    if let forcedUpdate = ios["forcedUpdate"] as? [String: Any] {
                                        let minSupportedVersion = forcedUpdate["minSupportedVersion"] as? String
                                        print("Min Supported Version: \(minSupportedVersion ?? "N/A")")
                                    }
                                }
                            } catch {
                                print("Error parsing JSON: \(error.localizedDescription)")
                            }
                        }
                    } else {
                        print("Failed to fetch iOS config")
                    }
                } else {
                    print("RemoteConfig fetch error: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
            
            // TerminalKey 가져오기
                    TerminalKeyManager.shared.fetchTerminalKey(deviceId: "D0A92F40-874F-4B41-87A2-AA9A531C18BF") { result in
                        switch result {
                        case .success(let terminalKey):
                            print("Fetched TerminalKey: \(terminalKey)")
                        case .failure(let error):
                            print("Failed to fetch TerminalKey: \(error)")
                        }
                    }

            let splashViewController = SplashViewController()
            window?.rootViewController = splashViewController
            window?.makeKeyAndVisible()
            
            
            if let config = Bundle.main.object(forInfoDictionaryKey: "Config") as? [String: String] {
                if let test = config["MBS_URL"] {
                    print("THIS IS CONFIG:" + test)
                }
            }
            
            
            return true
        }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        TerminalKeyManager.shared.clearTerminalKey()
    }


}

