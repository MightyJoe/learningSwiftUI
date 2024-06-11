//
//  ContentView.swift
//  8 moonshot
//
//  Created by Joe Harrison on 2024-06-06.
//

import SwiftUI

struct SpecialTitle: View {
    var titleText: String
    var body: some View {
        ZStack {
        
        Text("Bible Study")
            .font(.largeTitle)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .fontDesign(.serif)
            .foregroundStyle(.green)
            .padding(20)
            .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            
        Text("Bible Study")
            .font(.largeTitle)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .fontDesign(.serif)
            .foregroundStyle(.black)
            .padding()
    }
    }
}

struct TopicImage: View {
    var pic: String
    var body: some View {
        ZStack{
            
            Image(pic)
                .resizable()
                .frame( width: 120, height: 80)
                .clipShape(.capsule)
                .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            Image(pic)
                .resizable()
                .frame( width: 110, height: 70)
                .clipShape(.capsule)
                .padding()
        }
    }
}

struct CustomText: View {
    let text: String

    var body: some View
    {
        Text(text)
    }
    
    init(_ passedIn: String)
    {
        print("Creating a new custom text")
        self.text = passedIn
    }
}

struct ContentView: View {
    var pics: [String] = ["bible", "manuscript", "painted_bible", "study"]
    var body: some View {
        ZStack 
        {
            //BACKGROUND
            Image(.bible)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack
            {
                SpecialTitle(titleText: "Bible Study")
                ScrollView 
                {
                    LazyVStack(spacing: 10)
                    {
                        ForEach(0..<100) 
                        {
                            CustomText("item \($0)")
                                .font(.title)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .scrollIndicators(.visible)
                }
//                ScrollView
//                {
//                    VStack
//                    {
//                        ForEach (0..<5) { index in
//                            TopicImage(pic: pics[index])
//                        }.padding()
//                    }.frame(maxWidth: .infinity)
//                }
            }
        }
    }
}

#Preview {
    ContentView()
}
