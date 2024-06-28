//
//  ContentView.swift
//  rps
//
//  Created by Joe Harrison on 2024-05-08.
//

import SwiftUI

//CUSTOM MODIFIER
struct BTNStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding(20)
        .background(.primary)
        //.clipShape(.capsule)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 5)
    }
}

//VIEW EXTENSION TO USE THE STYLE MORE EASILY
extension View {
    func normalButton() -> some View{
        modifier(BTNStyle())
    }
    
}

//VIEW COMPOSISTION
struct LevelOneBackground: View{
    var body: some View{
        ZStack{
            VStack(spacing: 0){
                LinearGradient(colors: [.blue, .blue], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                LinearGradient(colors: [.blue, .white], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                LinearGradient(colors: [.white, .blue], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                LinearGradient(colors: [.blue, .green], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                LinearGradient(colors: [.green, .green], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            }.ignoresSafeArea()
            VStack(spacing: 0){
                LinearGradient(colors: [.clear, .blue], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            }.ignoresSafeArea()
            RadialGradient(colors: [.clear, .clear], center: .center, startRadius: 0, endRadius: 1000).ignoresSafeArea()
        }
    }
}

struct ContentView: View {
    @State var opponentChoice = Cards.rock
    @State var userChoice = Cards.rock
    @State var shouldWin = Bool.random()
    @State var winLoseText = "Game Ready!"
    @State var score = 0
    
    enum Cards {
    case rock
    case paper
    case scissors
    }
    
    var body: some View {
        ZStack{
            LevelOneBackground()
            VStack {
                HStack{
                    Text("Score: ")
                    Text("\(score)")
                    Spacer()
                }
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                
                Text("(Opponent's Pick)")
                Text("\(GetStringName(card: opponentChoice))").font(.largeTitle)
                Spacer()
                Spacer()
                Spacer()
                Text("vs.")
                Spacer()
                Spacer()
                Text("\(GetStringName(card: userChoice))").font(.largeTitle)
                Text("(Your Pick)")
                Spacer()
                
                Spacer()
                Spacer()
                Text("\(winLoseText)").font(.largeTitle)
                Spacer()
                Spacer()

                Spacer()
                Spacer()
                HStack{
                    Button {
                        opponentChoice = GetRandomCard()
                        userChoice = Cards.rock
                        score += GetScore(myCard: Cards.rock, opponentCard: opponentChoice)
                        winLoseText = GetWinLoseText(myCard: Cards.rock, opponentCard: opponentChoice)
                        
                    } label: {
                        Text("ROCK").tint(.white)
                    }.normalButton()
                    Button {
                        opponentChoice = GetRandomCard()
                        userChoice = Cards.paper
                        score += GetScore(myCard: Cards.paper, opponentCard: opponentChoice)
                        winLoseText = GetWinLoseText(myCard: Cards.paper, opponentCard: opponentChoice)
                    } label: {
                        Text("PAPER").tint(.white)
                    }.normalButton()
                    Button {
                        opponentChoice = GetRandomCard()
                        userChoice = Cards.scissors
                        score += GetScore(myCard: Cards.scissors, opponentCard: opponentChoice)
                        winLoseText = GetWinLoseText(myCard: Cards.scissors, opponentCard: opponentChoice)
                    } label: {
                        Text("SCISSORS").tint(.white)
                    }.normalButton()
                }
                Spacer()
            }
            .padding()
        }
    }
    
    /**
     Gets what should be displayed based on the outcome of the score.
     */
    func GetWinLoseText(myCard: Cards, opponentCard: Cards) -> String{
        switch(GetScore(myCard: myCard, opponentCard: opponentCard)){
        case 0:
            return "Draw!"
        case 1:
            return "WIN!"
        default:
            return "Lose."
        }
    }
    
    /**
     Determines if you won this round.
     */
    func GetScore(myCard: Cards, opponentCard: Cards) -> Int {
        
        if(myCard == opponentCard)
        {
            return 0;
        }
        switch(myCard){
        case .rock:
            return (opponentCard == Cards.scissors) ? 1 : -1
        case .paper:
            return (opponentCard == Cards.rock) ? 1 : -1
        case .scissors:
            return (opponentCard == Cards.paper) ? 1 : -1
        }
    }
    
    /**
     Returns a card at random.
     */
    func GetRandomCard() -> Cards {
        let choice = Int.random(in: 0...2)
        if(choice == 0)
        {
            return Cards.rock
        }
        else if (choice == 1)
        {
            return Cards.paper
        }
        else
        {
            return Cards.scissors
        }
    }
    
    /**
     Given a card, this will return a string representation of the enum.
     */
    func GetStringName(card: Cards) -> String{
        switch(card){
            
        case .rock:
            return "ROCK"
        case .paper:
            return "PAPER"
        case .scissors:
            return "SCISSORS"
        }
    }
}

#Preview {
    ContentView()
}
