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
// it is necessary to integrate two extensions into one
//
extension Habit {
    
    static let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    static var name: String {
        return "Habit"
    }
    static var currentHabit: Habit? {
        return getHabitFromId(id: RecordData.currentHabitId)
    }
    
    static func addData(habitName: String) {
        var habitArray = getDataArray()
        
        let data = Habit(context: context!)
        data.name = habitName
        data.id = UUID().uuidString
        
        habitArray.append(data)
        
        // Set current habit to this data
        UserDefaults.standard.setValue(data.id, forKey: RecordData.currentHabitKey)
        
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
    
    static func deleteData(data _data: Habit?) {
        guard let data = _data else {
            print("ERROR")
            return
        }
        
        context?.delete(data)
        
        // Delete recordData which is a data of this habit
        let recordArray = RecordData.getDataArray()
        
        for record in recordArray {
            if record.habitID == data.id {
                context?.delete(record)
            }
        }
        
        // Set random habit to new current habit
        let habitArray = getDataArray()
        var nextHabit: String?
        if habitArray.count > 0 { nextHabit = habitArray[0].id }
        UserDefaults.standard.setValue(nextHabit, forKey: RecordData.currentHabitKey)
        
        self.save()
    }
    
    static func editCurrentHabitName(newName: String) {
        currentHabit?.name = newName
        self.save()
    }
    
    static func getHabitFromId(id: String?) -> Habit? {
        if id == nil { return nil }
        
        let habitArray = getDataArray()
        
        for habit in habitArray {
            if habit.id == id {
                return habit
            }
        }
        
        return nil
    }
    
}
