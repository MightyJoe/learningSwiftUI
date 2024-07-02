//
//  ContentView.swift
//  P10 Cupcake Corner
//
//  Created by Joe Harrison on 2024-07-02.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()
    var body: some View 
    {
        List(results, id: \.trackId) 
        { item in
            HStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"))
                { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Text("Error Loading Image")
                    } else {
                        ProgressView()
                    }
                }.frame(width: 50, height: 50)
                VStack(alignment: .leading)
                {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }
        }.task {
            await loadData()
        }
    }
    
    func loadData() async 
    {
        guard let url = URL(string: "https://itunes.apple.com/search?term=weird+al&entity=song")
        else
        {
            print("invalid url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data)
            {
                results = decodedResponse.results
            }
        } catch
        {
            print("Invalid data")
        }
    }
}


#Preview {
    ContentView()
}