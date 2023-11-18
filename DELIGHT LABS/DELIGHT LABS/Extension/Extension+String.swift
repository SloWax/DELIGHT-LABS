//
//  Extension+String.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//

import Foundation

extension String {
    
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = dateFormatter.date(from: self) else { fatalError(self) }
        
        return date
    }
    
    func toDollar(_ isPositive: Bool) -> String {
        var toDouble = Double(self) ?? 0
        
        if !isPositive {
            toDouble = (Double(self) ?? 0) * -1
        }
        
        let toResult = String(format: "%.1f", toDouble)
        
        switch isPositive {
        case true : return "$\(toResult)"
        case false: return "-$\(toResult)"
        }
    }
}

extension Date {
    
    func toString(dateFormat format: String = "h:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
}
