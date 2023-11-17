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
        let amount: String // "-1524.31"
        let name: String // "Prince Vidal Trantow"
        let timestamp: String // "2023-11-01T00:00:00Z"
        let type: String // "transfer"
    }
}
