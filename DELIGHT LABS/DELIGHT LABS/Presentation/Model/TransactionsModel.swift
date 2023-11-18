//
//  TransactionsModel.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//

import Foundation

struct TransactionsModel: Codable {
    let amount: Double
    let name: String
    let time: Date
    let type: String 
    let isPositive: Bool
}
