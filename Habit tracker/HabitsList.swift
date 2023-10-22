//
//  HabitsList.swift
//  Habit tracker
//
//  Created by Слава Гринюк on 12.10.23.
//

import Foundation
class Habits: ObservableObject{
    @Published var items = [Habit](){
    didSet{
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items){
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
    }
}
init() {
    if let savedItems = UserDefaults.standard.data(forKey: "Items") {
        if let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedItems) {
            items = decodedItems
            return
        }
    }

    items = []
}
}
