//
//  ProposalView.swift
//  PushNotificationExample
//
//  Created by Shahriar Nasim Nafi on 23/8/21.
//

import SwiftUI

struct ProposalView: View {
    
    @ObservedObject var proposalCounter = ProposalCounter.shared
    
    var body: some View {
        HStack {
            CircledCounterView(backgroundColor: Color.green, count: $proposalCounter.accepted, title: "Accepted")
            CircledCounterView(backgroundColor: Color.red, count: $proposalCounter.rejected, title: "Rejected")
        }
        .navigationBarTitle("Proposal View", displayMode: .inline)
        
    }
}

struct ProposalView_Previews: PreviewProvider {
    static var previews: some View {
        ProposalView()
    }
}
