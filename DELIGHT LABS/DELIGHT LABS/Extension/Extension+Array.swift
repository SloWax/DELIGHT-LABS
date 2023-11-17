//
//  Extension+Array.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//

import Foundation

extension Array {
    func splitRange(_ index: UInt) -> Array {
        guard self.count >= index else { return [] }
        
        let result = self[0...Int(index)]
        return Array(result)
    }
}
