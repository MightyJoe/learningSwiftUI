//
//  ContentView.swift
//  multiplying-game
//
//  Created by Joe Harrison on 2024-06-03.
//

import SwiftUI

struct ContentView: View {
    @State var highestValue: Int = 2
    @State var numberOfQuestions: Int = 1
    @State var firstNumber: Int = 0
    @State var secondNumber: Int = 0
    @State var score: Int = 0
    @State var answer = ""
    @State var buttonVisible = false
    @State var questionsAnswered = 0
    
    var body: some View {
        VStack {
            Button("New Game"){
                newGame()
            }
            Stepper("Highest Number?",  value: $highestValue, in: 2...12, step: 1)
            
            HStack{
                Spacer()
                Text("\(highestValue)")
                    .font(.largeTitle)
            }
            Stepper("How many questions?",  value: $numberOfQuestions, in: 1...100, step: 1)
            HStack{
                Spacer()
                Text("\(numberOfQuestions)")
                    .font(.largeTitle)
            }
            .font(.largeTitle)
            
            HStack{
                Text("\(firstNumber) X \(secondNumber) = ")
                    .font(.largeTitle)
            }
            TextField(LocalizedStringKey("ENTER ANSWER"), text: $answer)
                .font(.title)
                .keyboardType(.numberPad)
                .frame(width: 250, alignment: .center)
                .multilineTextAlignment(.center)
                .onSubmit {
                    buttonVisible = answer.count > 0
                }

            Button("Submit"){
                if(buttonVisible && questionsAnswered < numberOfQuestions)
                {
                    askQuestion(guessString: answer)
                    
                }
            }.padding(20)
                .background(.blue)
                .clipShape(.capsule)
                .foregroundStyle(.white)
                .opacity(buttonVisible ? 1.0 : 0.3)
                
            Text("Score: \(score)")
            Text("Questions Answered: \(questionsAnswered)")
            Spacer()
        }
        .padding()
        .onAppear(){
            newGame()
        }
    }
    func askQuestion(guessString: String){
        
        let guessInt = (Int)(guessString) ?? -1
        
        var myAnswer: Int = firstNumber * secondNumber
        
        if(guessInt == myAnswer)
        {
            score += 1
        }
        else
        {
            score -= 1
        }
        
        questionsAnswered += 1
        
        answer = ""
        
        firstNumber = Int.random(in: 0...highestValue)
        secondNumber = Int.random(in: 0...highestValue)
    }
    
    func newGame(){
        firstNumber = Int.random(in: 0...highestValue)
        secondNumber = Int.random(in: 0...highestValue)
        answer = ""
        buttonVisible = false
        questionsAnswered = 0
        score = 0
    }
}

#Preview {
    ContentView()
}
