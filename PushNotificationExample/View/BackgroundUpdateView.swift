//
//  BackgroundUpdateView.swift
//  PushNotificationExample
//
//  Created by Shahriar Nasim Nafi on 23/8/21.
//

import SwiftUI
import Kingfisher
import Defaults


struct BackgroundUpdateView: View {
    
    @Default(.backgroundUpdatedTitle) var BackgroundUpdatedTitle
    @Default(.backgroundUpdatedImageUrl) var backgroundUpdatedImageUrl
    var body: some View {
        VStack {
            KFImage(URL(string: backgroundUpdatedImageUrl)!)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 180)
                .padding()
            Text(BackgroundUpdatedTitle)
                .font(.title)
                .bold()
        }
        .navigationBarTitle("Background Updates")
    }
}

struct BackgroundUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundUpdateView()
    }
}
