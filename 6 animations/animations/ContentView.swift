//
//  ContentView.swift
//  animations
//
//  Created by Joe Harrison on 2024-05-30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmmount1 = 1.0
    @State private var animationAmmount = 1.0
    @State private var myColor = Color.red
    @State private var flipped = false
    @State private var boundAmmount = 1.0

    var body: some View {
          
        
        return VStack{
            Stepper("Scale ammount", value: $boundAmmount.animation(.easeIn(duration: 1.0).repeatCount(1, autoreverses: false)))
            Circle()
                .scaleEffect(boundAmmount/10)
            Spacer()
            Button("Animations"){
                changeAnimationAmmount()
            }
            .padding(50)
            .background(myColor)
            .foregroundStyle(.yellow)
            .clipShape(.ellipse)
            .scaleEffect(animationAmmount1)
            .animation(.spring(duration: 0.15, bounce: 0.8), value: animationAmmount1)
            .animation(.default, value: myColor)
            
            Spacer()
            
            Button("Click Me!"){
                
            }.padding(50)
                .background(myColor)
                .foregroundStyle(.yellow)
                .clipShape(.capsule)
                .overlay(
                    Capsule()
                        .stroke(.red)
                        .scaleEffect(animationAmmount)
                        .opacity(2 - animationAmmount)
                        .animation(
                            .easeOut(duration: 1.17)
                            .repeatForever(autoreverses: false),
                            value: animationAmmount)
                )
                .onAppear(){
                    animationAmmount = 2
                }
            Spacer()
        }
    }
    
    func changeAnimationAmmount() {
        flipped = !flipped
        if( flipped )
        {
            animationAmmount1 = 1
            myColor = Color.green
        }
        else {
            animationAmmount1 = 2
            myColor = Color.blue
        }
        
    }
}

#Preview {
    ContentView()
}
