//
//  MissionCardView.swift
//  8 moonshot
//
//  Created by Joe Harrison on 2024-06-19.
//

import SwiftUI

struct MissionCardView: View {
    let mission: Mission
    
    var body: some View {
        VStack
        {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        ).frame(maxWidth: 150)
            .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    return MissionCardView(mission: missions[0])
        .preferredColorScheme(.dark)
        
        
}
