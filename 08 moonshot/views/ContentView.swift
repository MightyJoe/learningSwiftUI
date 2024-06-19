//
//  ContentView.swift
//  8 moonshot
//
//  Created by Joe Harrison on 2024-06-06.
//

import SwiftUI

struct ContentView: View 
{
    @State private var gridView = true
    @State private var path = NavigationPath()
    var body: some View
    {
        NavigationStack(path: $path) {
            VStack{
                if(gridView)
                {
                    MissionsGridView()
                }
                else
                {
                    MissionListView()
                }
            }
            .toolbar{
                Button("Switch View")
                {
                    gridView.toggle()
                }
            }
        }.preferredColorScheme(.dark)
    }//body
    
}//ContentView

#Preview 
{
    ContentView()
}//Preview
