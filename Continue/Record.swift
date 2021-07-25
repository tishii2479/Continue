//
//  Record.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/25.
//

import Foundation

struct Record<RecordType> {
    var date: Date
    var record: RecordType
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        return dateFormatter.string(from: date)
    }
}
