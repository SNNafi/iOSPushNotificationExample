//
//  AppDelegate.swift
//  PushNotificationExample
//
//  Created by Shahriar Nasim Nafi on 18/8/21.
//

import UIKit
import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            
            guard granted else { return }
            
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
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
    
    // MARK: PUSH NOTIFICATION
    
    // iOS will call this method once the device has sucessfully registered for push notifications
    // As the simulator is not able to receive notifications remotely the delegate method is never called
    func application(
        _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.reduce("") { $0 +
            String(format: "%02x", $1) }
        print(token)
        // 33aa4c82d047e9746b47ddfef3badc3e3fd1b4cf17a025fe5fea63a8cc87e953
    }
    
    // iOS will call this method when it fails to register the device for pushes
    func application(
    _ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { print(error)
    }
    
    
}
