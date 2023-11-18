//
//  TransactionsDto.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//

import Foundation

struct TransactionsDto: Codable {
    struct Request: Codable {
    }
    
    struct Response: Codable {
        let amount: String
        let name: String
        let timestamp: String
        let type: String
    }
}
