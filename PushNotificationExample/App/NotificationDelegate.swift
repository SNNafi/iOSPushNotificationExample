//
//  NotificationDelegate.swift
//  PushNotificationExample
//
//  Created by Shahriar Nasim Nafi on 22/8/21.
//

import UserNotifications

final class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate, ObservableObject {
    
    
    @Published var isNotificationView = false
    @Published var notificationText = ""
    @Published var notificationImageUrl = "https://app.snnafi.com/assets/images/banner/snnaafiii.jpg"
    
    // Display push notification when app in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        if #available(iOS 14, *) {
            completionHandler([.badge, .sound, .banner])
        } else {
            completionHandler([.badge, .sound, .alert])
        }
    }
    
    // Handle tap on push notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        defer { completionHandler() }
        
        if response.notification.request.content.categoryIdentifier == "nil" {
            
            //  This is called for normal tap
            guard response.actionIdentifier == UNNotificationDefaultActionIdentifier else {
                return
            }
            
            if response.notification.request.content.userInfo["notification"] != nil {
                
                guard let notification = (response.notification.request.content.userInfo["notification"] as? [String: String]), let title = notification["title"], let imageUrl = notification["image"]  else { return }
                
                notificationText = title
                notificationImageUrl = imageUrl
                isNotificationView = true
            }
            
        } else {
            let identity = response.notification.request.content.categoryIdentifier
            guard identity == categoryIdentifier,
                  let action = Proposal(rawValue: response.actionIdentifier) else {
                return
            }
            
            switch action {
            case .accept:
                ProposalCounter.shared.accepted+=1
            case .reject:
                ProposalCounter.shared.accepted-=1
            }
        }
    }
}

