//
//  RecordData.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/26.
//

import UIKit
import CoreData

extension RecordData {
    
    static func addData(date: Date, record: Int32) {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecordData")
        var recordArray = try! context?.fetch(fetchRequest) as! [RecordData]
        
        let data = RecordData(context: context!)
        data.record = record
        data.date = date
        
        recordArray.append(data)
        
        self.save()
    }
    
    static func getArray() -> [RecordData] {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecordData")
        var recordArray = try! context?.fetch(fetchRequest) as! [RecordData]
        
        // ISSUE:
        // performance?
        recordArray.sort { $0.date! > $1.date! }
        
        return recordArray
    }
    
    static func clearArray() {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecordData")
        let recordArray = try! context?.fetch(fetchRequest) as! [RecordData]
        
        for record in recordArray {
            context?.delete(record)
        }
        
        self.save()
    }
    
    static func save() {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
}
