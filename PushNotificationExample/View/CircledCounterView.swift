//
//  CircledCounterView.swift
//  PushNotificationExample
//
//  Created by Shahriar Nasim Nafi on 23/8/21.
//

import SwiftUI

struct CircledCounterView: View {
    var backgroundColor: Color = Color.green
    @Binding var count: Int
    var title: String = ""
    var body: some View {
        VStack {
            Circle()
                .frame(width: 100, height: 100)
                .overlay(Text(String(count)).foregroundColor(.white).font(.title))
                .clipShape(Circle())
                .foregroundColor(backgroundColor)
            Text(title)
                .font(.title)
                .bold()
        }
        .padding()
        .border(backgroundColor, width: 5)
    }
}

struct CircledCounterView_Previews: PreviewProvider {
    static var previews: some View {
        CircledCounterView(count: .constant(10))
    }
}
