//
//  ContentView.swift
//  8 moonshot
//
//  Created by Joe Harrison on 2024-06-06.
//

import SwiftUI

struct ContentView: View {
    
    let gridLayout = [
        GridItem(.adaptive(minimum: 80, maximum: 100))
    ]
    
    var pics: [String] = ["bible", "manuscript", "painted_bible", "study"]
    var body: some View {
        ScrollView {
            LazyVGrid( columns: gridLayout)
            {
                ForEach(0..<1000)
                {
                    Text("Item \($0)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
