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
    
    static let name = "Habit"
    
    static func addData(habitName: String) {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        var habitArray = try! context?.fetch(fetchRequest) as! [Habit]
        
        let data = Habit(context: context!)
        data.name = habitName
        data.id = UUID()
        
        habitArray.append(data)
        
        self.save()
    }
    
    static func getArray() -> [Habit] {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        let habitArray = try! context?.fetch(fetchRequest) as! [Habit]
        
        return habitArray
    }
    
    static func clearArray() {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        let habitArray = try! context?.fetch(fetchRequest) as! [RecordData]
        
        for habit in habitArray {
            context?.delete(habit)
        }
        
        self.save()
    }
    
    static func save() {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    static func deleteData(data: Habit) {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

        context?.delete(data)
        
        self.save()
    }
    
}
