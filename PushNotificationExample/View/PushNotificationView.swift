//
//  PushNotificationView.swift
//  PushNotificationExample
//
//  Created by Shahriar Nasim Nafi on 18/8/21.
//

import SwiftUI

struct PushNotificationView: View {
    
    @EnvironmentObject var notificationDelegate: NotificationDelegate
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, world!")
                    .padding()
                NavigationLink(
                    destination: BackgroundUpdateView(),
                    label: {
                        Text("Background Updates")
                    })
                NavigationLink(
                    destination: ProposalView(),
                    label: {
                        Text("Proposal View")
                    })
                
                NavigationLink("", destination: NotificationInfoView(), isActive: $notificationDelegate.isNotificationView)
            }
        }
    }
}

struct PushNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        PushNotificationView()
    }
}
