//
//  ContentView.swift
//  9.5 Habbits
//
//  Created by Joe Harrison on 2024-06-25.
//

import SwiftUI

// The main starting view.
struct ContentView: View 
{
    @State var myHabits: Habits = Habits()
    
    var body: some View
    {
        NavigationStack 
        {
            List {
                ForEach(myHabits.items) { item in
                    NavigationLink {
                        HabitDetails(habitList: myHabits, habitItem: item)
                        
                    } label: {
                        HStack {
                            Text(item.summary)
                            Spacer()
                            Text("\(item.timesPerformed)")
                        }
                    }
                }.onDelete(perform: { indexSet in
                    myHabits.items.remove(atOffsets: indexSet)
                })
            }
            Spacer()
            NavigationLink {
                HabitDetails(habitList: myHabits,
                             habitItem: Habit(
                                id: UUID(),
                                summary: "",
                                description: "",
                                timesPerformed: 0,
                                consecutiveDays: 0,
                                startDate: Date(),
                                lastTimePerformed: Date()))
                    
            } label:
            {
                Text("New Item").padding()
            }.navigationTitle("My Habits")
//            Button("Delete All")
//            {
//                myHabits.items.removeAll()
//            }
        }
    }
}

#Preview 
{
    return ContentView()
}
