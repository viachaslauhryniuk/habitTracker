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
    var daysCount: [String: Int]
    var isChecked:Bool = false{
        willSet{
            
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                var today = dateFormatter.string(from: Date.now)
                if newValue {
                    if !self.daysCount.keys.contains(today){
                        self.daysCount[today] = Int.random(in: 1...10)
                    }
                        
                }
                else{
                    if self.daysCount.keys.contains(today){
                        self.daysCount.removeValue(forKey: today)
                    }
                }
                   
              
               
            }
        }
    }

