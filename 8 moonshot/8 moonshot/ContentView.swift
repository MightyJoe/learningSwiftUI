//
//  ContentView.swift
//  8 moonshot
//
//  Created by Joe Harrison on 2024-06-06.
//

import SwiftUI

struct ContentView: View 
{
    let astronauts = Bundle.main.decode("astronauts.json")
    var body: some View
    {
        Text("Json entry count: \(astronauts.count)")
    }
}

#Preview 
{
    ContentView()
}
