//
//  HabitsStruct.swift
//  Habit tracker
//
//  Created by Слава Гринюк on 12.10.23.
//

import Foundation
import SwiftUI
struct Habit:  Hashable, Equatable, Identifiable, Codable{
    let id = UUID()
    let name: String
    let description: String
    let daysGoal: Int
    var daysCount = 0
    var isChecked = false
}
