//
//  HabitsList.swift
//  Habit tracker
//
//  Created by Слава Гринюк on 12.10.23.
//

import Foundation
class Habits: ObservableObject{
    @Published var items = [Habit]()
}
