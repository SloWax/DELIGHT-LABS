//
//  TransactionsModel.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//

import Foundation

struct TransactionsModel: Codable {
    let amount: String // ": "-1524.31"
    let name: String // "Prince Vidal Trantow"
    let time: String // "2023-11-01T00:00:00Z"
    let type: String // "transfer"
    let isPositive: Bool
}
