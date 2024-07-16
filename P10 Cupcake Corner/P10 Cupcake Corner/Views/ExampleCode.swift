//
//  ContentView.swift
//  P10 Cupcake Corner
//
//  Created by Joe Harrison on 2024-07-02.
//

import SwiftUI

@Observable
class User: Codable {
    
    //Provide SwiftUI with a remapping enum so that it encodes JSON correctly.
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    //will be _name when encoded to JSON, so see CodingKeys for what it resolves to.
    var name = "Weird Al"
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ExampleCode: View {
    @State private var results = [Result]()
    @State private var username = ""
    @State private var email = ""
    @State private var hapticNow = false
    
    var disableForm: Bool {
        return username.count < 2 ||
                email.count < 3 ||
                !email.contains("@")
    }
    
    var body: some View
    {
        VStack 
        {
            Form
            {
                Section {
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                }
                Section {
                    Button("Create account") {
                        print("Creating account...")
                    } .disabled(disableForm)
                }
                Section {
                    Button("Encode Al", action: encodeAl)
                        .sensoryFeedback(.success, trigger: hapticNow)
                    
                }
            }.frame(height: 300)
            .background()
            .cornerRadius(10.0)
                
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
            }
            .task {
                await loadData()
            }
        }.background(.gray)
    }
    
    func encodeAl() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
        hapticNow.toggle()
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
    ExampleCode()
}
