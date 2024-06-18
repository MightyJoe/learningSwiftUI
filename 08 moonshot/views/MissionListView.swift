//
//  MissionListView.swift
//  8 moonshot
//
//  Created by Joe Harrison on 2024-06-18.
//

import SwiftUI

struct MissionListView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View 
    {
        ZStack{
            Spacer().background(.darkBackground).ignoresSafeArea()
                List {
                    Section
                    {
                        ForEach(missions)
                        { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                HStack
                                {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundStyle(.white.opacity(0.7))
                                        Spacer()
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                    .cornerRadius(15)
                                    .padding()
                                    
                                    Spacer()
                                }
                            }
                        }
                        .navigationTitle("Moonshot")
                        .listRowBackground(Color(.darkBackground))
                        
                    }.preferredColorScheme(.dark)
                        //.background(.darkBackground)
                        //.listRowBackground(Color.clear)
                        .listRowSeparator(.visible)
                }.scrollContentBackground(.hidden)
                    .background(.darkBackground)
        }
    }
}

#Preview {
    NavigationStack {
        MissionListView()
    }.preferredColorScheme(.dark)
}
