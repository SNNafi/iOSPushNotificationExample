//
//  ApnsUploads.swift
//  PushNotificationExample
//
//  Created by Shahriar Nasim Nafi on 22/8/21.
//

import UIKit

extension AppDelegate {
    
    /// Request for push notification
    /// - Parameter application: `UIApplication` object
    func registerForPushNotifications(application: UIApplication) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            
            guard granted else { return }
            
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
    
    
    /// Send `TokenDetails`  to server
    /// - Parameters:
    ///   - urlString: Url of the server
    ///   - deviceToken: Device token as `Data` object
    func sendPushNotificationDetails(to urlString: String, using deviceToken: Data) {
        
        let token = deviceToken.reduce("") { $0 +
            String(format: "%02x", $1) }
        
        // Save token to `UserDefaults` if not exist
        if !isKeyPresentInUserDefaults(key: "PushToken") {
            UserDefaults.standard.set(token, forKey: "PushToken")
        }
        
        // If token is different, send to server
        if token != UserDefaults.standard.string(forKey: "PushToken") {
            guard let url = URL(string: urlString) else {
                fatalError("Invalid URL string") }
            var details = TokenDetails(token: deviceToken)
            
            #if DEBUG
            details.debug = 1
            print(details)
            #endif
            
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = details.encoded()
            URLSession.shared.dataTask(with: request).resume()
        }
    }
    
    /// Check if specific key exists in `UserDefaults`
    /// - Parameter key: Key to check
    /// - Returns: `True` if exists or `False`
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}


