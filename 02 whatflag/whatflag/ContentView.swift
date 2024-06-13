//
//  ContentView.swift
//  whatflag
//
//  Created by Joe Harrison on 2024-04-24.
//

import SwiftUI

/**
 Defines how a flag image look as the button's label.
 */
struct FlagView: View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

/**
 Styles a flagButton
 */
struct FlagButton: View {
    var function: () -> Void //Closure (function pointer/lamda in other languages)
    var imageName: String
    @State var animateBool: Bool
    var body: some View {
        Button {
            function()
            animateBool.toggle()
        }
    label: {
        FlagView(imageName: imageName)
            
    }.background(.red)
            .clipShape(.capsule)
            .padding(10)
            .rotationEffect( animateBool ? .degrees(0) : .degrees(360), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .animation(.bouncy, value: animateBool)
    }
}

//VIEW CODE
struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = "Score"
    @State private var score: Int = 0
    @State private var message: String = ""
    @State private var showingScore = false
    @State private var animateBool = true
    @State private var animationNumber = 0
    @State private var clickedButtonIndex = 0
    @State private var buttonClicked = false
    
    var body: some View {
        ZStack{
            //BACKGROUND
            LinearGradient(colors: [.blue, .orange], startPoint: .top, endPoint: .bottom).ignoresSafeArea()

            //BODY
            VStack(spacing: 15){
                
                //TITLE
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                        
                }
                .padding()
                
                //FLAGS
                ForEach(0..<3)
                { number in
                    
                    FlagButton( function: { message = flagTapped(number); 
                        showingScore = true;
                        buttonClicked = true;
                        clickedButtonIndex = number //So that we can differentiate clicked vs. not clicked.
                    },
                               imageName: countries[number], animateBool: false
                    ).opacity((buttonClicked && clickedButtonIndex != number) ? 0.2: 1.0)
                        .scaleEffect((buttonClicked && clickedButtonIndex != number) ? 0.5 : 1.0)
                        .animation(.spring(), value: buttonClicked)
                }
            }
            .frame(maxWidth: .infinity)
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 20))
            .padding()
            .padding(.vertical, 20)
            .animation(.spring(duration: 0.15, bounce: 0.8), value: animateBool)
            
        } //ALERT (LET USER KNOW SCORE)
        .alert(scoreTitle, isPresented: $showingScore){
            Text(message)
            Button("OK", action: askQuestion)
            
        }
    }
    
    /**
     What happens when a flag is tapped.
     */
    func flagTapped(_ number: Int) -> String
    {
        if(number == correctAnswer)
        {
            //you win
            score = score + 1
            return "Correct! Your score is \(score)"
        }
        else
        {
            return "Wrong. Your score is \(score)"
        }
    }
    
    /**
     Shuffles the flags.
     */
    func askQuestion() {
  
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        buttonClicked = false
    }
}

#Preview {
    ContentView()
}
