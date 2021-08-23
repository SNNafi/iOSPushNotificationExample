//
//  NotificationInfoView.swift
//  PushNotificationExample
//
//  Created by Shahriar Nasim Nafi on 22/8/21.
//

import SwiftUI
import Kingfisher


struct NotificationInfoView: View {
    
    @EnvironmentObject var notificationDelegate: NotificationDelegate
    var body: some View {
        VStack {
            KFImage(URL(string: notificationDelegate.notificationImageUrl)!)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 180)
                .padding()
            Text(notificationDelegate.notificationText)
                .font(.title)
                .bold()
        }
    }
}

struct NotificationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationInfoView()
    }
}
