//
//  RecordData.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/26.
//

import UIKit
import CoreData

//
// ISSUE:
// this extension is almost the same with Habit.swift
// it is necessary to integrate two extensions in one
//
extension RecordData {
    
    static let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    // TODO: get current habitID from userdefaults
    static var currentHabit: Habit? = nil
    static let name = "RecordData"
    
    static func addData(date: Date, record: Int32) {
        
        guard let habitID = currentHabit?.id else {
            // TODO:
            // show error
            print("NO_HABIT_ID")
            return
        }
        
        var recordArray = getDataArray()
        
        let data = RecordData(context: context!)
        data.record = record
        data.date = date
        data.habitID = habitID
        
        recordArray.append(data)
        
        self.save()
    }
    
    static func save() {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    static func deleteData(data: RecordData) {
        context?.delete(data)
        
        self.save()
    }
    
    static func getDataArray(sortAscending: Bool = false) -> [RecordData] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        if let id = currentHabit?.id {
            let predicate = NSPredicate(format: "%K = %@", "habitID", id)
            fetchRequest.predicate = predicate
        }
        
        var recordArray = try! context?.fetch(fetchRequest) as! [RecordData]
        
        // ISSUE: performance?
        recordArray.sort { $0.date! > $1.date! }
        
        if sortAscending {
            recordArray.reverse()
        }
        
        return recordArray
    }
    
}
