//
//  MissionsGridView.swift
//  8 moonshot
//
//  Created by Joe Harrison on 2024-06-17.
//

import SwiftUI

struct MissionsGridView: View 
{
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
        
    var body: some View {

        ScrollView
        {
            LazyVGrid(columns: columns)
            {
                ForEach(missions) { mission in
                    NavigationLink(value: mission)
                    {
                        MissionCardView(mission: mission)
                    }
                }
                
            }.padding([.horizontal, .bottom])
        }
        .background(.darkBackground)
        .navigationTitle("Moonshot")
        .navigationDestination(for: Mission.self){ mission in
            MissionView(mission: mission, astronauts: astronauts)
        }
    }
}

#Preview {
    @State var myPath = NavigationPath()
   return NavigationStack(path: $myPath)
    {
        MissionsGridView()
    }.preferredColorScheme(.dark)
    
}
