//
//  HabitDetails.swift
//  9.5 Habbits
//
//  Created by Joe Harrison on 2024-06-25.
//

import SwiftUI

struct HabitDetails: View 
{    
    @State var habits: Habits
    @State var habit: Habit
    
    init(habitList: Habits, habitItem: Habit) {
        self.habits = habitList
        self.habit = habitItem
    }
    
    var body: some View
    {
        NavigationStack
        {
            VStack {
                VStack{
                    Text("Summary")
                    TextField("Summary", text: $habit.summary, axis: .vertical)
                        .font(.title)
                        .padding()
                        .border(.primary)
                    Text("Description")
                    TextField("Description", text: $habit.description, axis: .vertical)
                        .lineLimit(5...10)
                        .padding()
                        .border(.primary)
                }
                .padding()
                Text("Info").font(.headline)
                VStack{
                    HStack{
                        Text("Consecutive Days: ")
                        Spacer()
                        Text("\(habit.consecutiveDays)")
                    }
                    HStack {
                        Text("Start Time:")
                        Spacer()
                        Text("\(habit.startDate.formatted(date: .numeric, time: .shortened))" )
                    }
                    HStack {
                        Text("Last Time Done:")
                        Spacer()
                        Text("\(habit.lastTimePerformed.formatted(date: .numeric, time: .shortened))" )
                    }
//                    HStack {
//                        Text("ID:")
//                        Spacer()
//                        Text("\(habit.id)" )
//                    }
                }
                Spacer()
                HStack
                {
                    Stepper(
                        value: $habit.timesPerformed,
                        step: 1)
                    {
                        Text("Habit Repeated: \(habit.timesPerformed) times.")
                    }
                    
                }
                Spacer()
            }
            .navigationTitle("Habit Details")
            .padding()
            .onDisappear(perform: {
                Save()
                print("Saved.")
            })
        }
    }
        
        func Save()
        {
            if(self.habit.summary == "" && self.habit.description == "" &&
               self.habit.timesPerformed == 0)
            {
                return;
            }
            var itemFound = false
            for item in 0 ..< habits.items.count {
                if(habits.items[item] == self.habit)
                {
                    habits.items[item] = self.habit
                    itemFound = true
                }
            }
            if(!itemFound)
            {
                habits.items.append(habit)
            }
            habits = habits
        }
    }
#Preview {
    let h = Habit(id: UUID(),
                  summary: "Learn Swift",
                  description: "Learn some swift code so that you can do more cooler stuff.",
                  timesPerformed: 42,
                  consecutiveDays: 13,
                  startDate: Date(),
                  lastTimePerformed: Date())
    
    return HabitDetails(habitList: Habits(), habitItem: h)
}
