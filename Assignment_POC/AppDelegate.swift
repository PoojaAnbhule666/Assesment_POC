//
//  AppDelegate.swift
//  Assignment_POC
//
//  Created by Pooja on 26/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var networkIsConnected = false
    private let reachability = try? Reachability()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupReachability()
        return true
    }
    // MARK: Reachability methods
    func setupReachability() {
        let notifCentre = NotificationCenter.default
        notifCentre.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as? Reachability
        let notificationname = NSNotification.Name("Reachability")
        switch reachability?.connection {
        case .wifi:
            networkIsConnected = true
            print("Reachable via WiFi")
            NotificationCenter.default.post(name: notificationname, object: ["connection": "wifi"])
            NotificationCenter.default.post(name: notificationname, object: nil, userInfo: ["connection": "wifi"])
        case .cellular:
            networkIsConnected = true
            print("Reachable via Cellular")
            NotificationCenter.default.post(name: notificationname, object: nil, userInfo: ["connection": "data"])
        case .none:
            networkIsConnected = false
            print("Network not reachable")
            NotificationCenter.default.post(name: notificationname, object: nil, userInfo: ["connection": "lost"])
        case .unavailable:
            networkIsConnected = false
            print("Network unavailable")
            NotificationCenter.default.post(name: notificationname, object: nil, userInfo: ["connection": "lost"])
        case .some(.none):
            break
        }
    }
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
