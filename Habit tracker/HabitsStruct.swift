//
//  HabitsStruct.swift
//  Habit tracker
//
//  Created by Слава Гринюк on 12.10.23.
//

import Foundation

struct Habit: Identifiable, Codable, Hashable{
    let id = UUID()
    let name: String
    let description: String
    let daysGoal: Int
    var daysCount = 0
    
}
