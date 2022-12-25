//
//  MailModel.swift
//  TestDeneme
//
//  Created by Bedirhan Altun on 11.12.2022.
//

import Foundation

struct MessageListCheck: Hashable, Codable {
    let idtoken: String
    let authcode: String
}

struct MessageList: Hashable,Codable {
    let messages: [Message]
}


struct Message: Hashable,Codable {
    let id: String
    let threadId: String
}
