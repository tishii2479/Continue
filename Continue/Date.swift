//
//  Date.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/26.
//

import Foundation

extension Date {
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
}
