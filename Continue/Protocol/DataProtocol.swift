//
//  DataProtocol.swift
//  Continue
//
//  Created by Tatsuya Ishii on 2021/07/27.
//

import Foundation

protocol DataProtocol : AnyObject {
    
    func reloadData()
    
    func openModal(data: RecordData?)
    
    func deleteAlert(data: RecordData)
    
    func openNewHabit()
    
}
