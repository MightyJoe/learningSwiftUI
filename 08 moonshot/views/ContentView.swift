//
//  ContentView.swift
//  8 moonshot
//
//  Created by Joe Harrison on 2024-06-06.
//

import SwiftUI

struct ContentView: View 
{
    var body: some View
    {
        NavigationStack
        {
            ScrollView
            {
                MissionsGridView()
            }.navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
        }
    }//body
}//ContentView

#Preview 
{
    ContentView()
}//Preview
