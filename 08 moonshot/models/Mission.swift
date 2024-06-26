//
//  Mission.swift
//  8 moonshot
//
//  Created by Joe Harrison on 2024-06-11.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable
{
    static func == (lhs: Mission, rhs: Mission) -> Bool {
        return lhs.id == rhs.id
    }
    
    struct CrewRole: Codable, Hashable
    {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        return launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
