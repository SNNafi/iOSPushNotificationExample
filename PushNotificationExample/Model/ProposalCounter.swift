//
//  Counter.swift
//  PushNotificationExample
//
//  Created by Shahriar Nasim Nafi on 23/8/21.
//

import Combine

final class ProposalCounter: ObservableObject {
    
 
    @Published public var accepted = 0
    @Published public var rejected = 0
    
    
    static let shared = ProposalCounter()
    private init() {}
}
