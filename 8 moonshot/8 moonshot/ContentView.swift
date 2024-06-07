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
    var pic: ImageResource
    var body: some View {
        ZStack{
            
            Image(.study)
                .resizable()
                .frame( width: 120, height: 80)
                .clipShape(.capsule)
                .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            Image(.study)
                .resizable()
                .frame( width: 110, height: 70)
                .clipShape(.capsule)
                .padding()
        }
    }
}

struct ContentView: View {
    var pics: [ImageResource] = [.bible, .latin, .manuscript, .paintedBible, .study]
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
                    ForEach (0..<5) { index in
                        TopicImage(pic: pics[index])
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
