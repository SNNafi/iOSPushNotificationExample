//
//  TokenDetails.swift
//  PushNotificationExample
//
//  Created by Shahriar Nasim Nafi on 22/8/21.
//

import Foundation


/// Token object for push notification
struct TokenDetails {
    
    private let encoder = JSONEncoder()
    /// token to send push notification
    let token: String
    /// if app is debug = 1 or production = 0
    var debug = 0
    
    init(token: Data) {
        self.token = token.reduce("") { $0 + String(format: "%02x", $1) }
        self.encoder.outputFormatting = .prettyPrinted
        
    }
    
    /// Encoded to send to server
    func encoded() -> Data {
        return try! encoder.encode(self)
    }
}


extension TokenDetails: Encodable {
    private enum CodingKeys: CodingKey {
        case token, debug
    }
}

extension TokenDetails: CustomStringConvertible {
    var description: String {
        return String(data: encoded(), encoding: .utf8) ?? "Invalid token" }
}
