//
//  Habit.swift
//  9.5 Habbits
//
//  Created by Joe Harrison on 2024-06-25.
//

import Foundation
import SwiftUI

@Observable
class Habit: Codable, Identifiable, Hashable, Equatable
{
    var id: UUID
    var summary: String
    var description: String
    var timesPerformed: Int {
        didSet {
            if( Calendar.current.isDateInYesterday(lastTimePerformed) )
            {
                consecutiveDays += 1
            }
            else {
                consecutiveDays = 1
            }
            lastTimePerformed = Date()
        }
    }
    var consecutiveDays: Int
    var startDate: Date
    var lastTimePerformed: Date
    
    init(id: UUID, summary: String, description: String, timesPerformed: Int, consecutiveDays: Int, startDate: Date, lastTimePerformed: Date) {
        self.id = id
        self.summary = summary
        self.description = description
        self.timesPerformed = timesPerformed
        self.consecutiveDays = consecutiveDays
        self.startDate = startDate
        self.lastTimePerformed = lastTimePerformed
    }
    
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    

}

@Observable
class Habits {
    var items = [Habit](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items)
            {
                UserDefaults.standard.set(encoded, forKey: "HabitList")
                print("DIDSET")
            }
        }
    }
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "HabitList"){
            if let decodedItems = try? JSONDecoder().decode([Habit].self,
                                                            from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}
