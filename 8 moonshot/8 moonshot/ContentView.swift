//
//  ContentView.swift
//  8 moonshot
//
//  Created by Joe Harrison on 2024-06-06.
//

import SwiftUI

struct ContentView: View 
{
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View
    {
        Text("Astronauts count: \(astronauts.count)")
        Text("Missions count: \(missions.count)")
    }
}

#Preview 
{
    ContentView()
}
