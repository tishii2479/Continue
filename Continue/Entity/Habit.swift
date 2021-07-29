//
//  Habit.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/28.
//

import UIKit
import CoreData

//
// ISSUE:
// this extension is almost the same with RecordData.swift
// it is necessary to integrate two extensions in one
//
extension Habit {
    
    static let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    static let name = "Habit"
    
    static func addData(habitName: String) {
        var habitArray = getDataArray()
        
        let data = Habit(context: context!)
        data.name = habitName
        data.id = UUID().uuidString
        
        habitArray.append(data)
        
        self.save()
    }
    
    static func getDataArray() -> [Habit] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        let habitArray = try! context?.fetch(fetchRequest) as! [Habit]
        
        return habitArray
    }
    
    static func save() {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    static func deleteData(data: Habit) {
        context?.delete(data)
        
        self.save()
    }
    
}
