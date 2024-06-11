//
//  Mission.swift
//  8 moonshot
//
//  Created by Joe Harrison on 2024-06-11.
//

import Foundation

struct Mission: Codable, Identifiable 
{
    struct CrewRole: Codable
    {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
