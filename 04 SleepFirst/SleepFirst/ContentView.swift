//
//  ContentView.swift
//  SleepFirst
//
//  Created by Joe Harrison on 2024-05-08.
//
import CoreML
import SwiftUI

struct ContentView: View 
{
    @State private var sleepAmmount = 8.0
    @State private var coffeeAmmount = 2.0
    @State private var wakeUp = defaultWakeupTime
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeupTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View
    {
        NavigationStack
        {
            Form{
                Section("WHEN DO YOU WANT TO WAKE UP?"){
                    HStack(alignment: .center){
                        VStack(alignment: .center){
                            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                    }
                }
                Section("INFORMATION NEEDED"){
                    VStack{
                        Text("How much sleep do you want?")
                        Stepper("\(sleepAmmount.formatted()) hours", value: $sleepAmmount, in: 4...12, step: 0.25)
                    }
                    VStack {
                        Text("Daily Coffee Intake?")
                        Stepper(coffeeAmmount == 1 ? "1 cup" : "\(coffeeAmmount.formatted()) cups", value: $coffeeAmmount, in: 1...20)
                    }
                }
            }
            .toolbar{
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert){
                Button("OK"){}
            } message: {
                Text(alertMessage)
            }
            .navigationTitle("Sleep First")
        }
    }
    
    func calculateBedtime()
    {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), coffee: Double(coffeeAmmount), actualSleep: sleepAmmount)
            
            let secondsToAdd: Double = prediction.estimatedSleep;
            
            let abcde = wakeUp - (sleepAmmount * 60 * 60 + secondsToAdd)
            
            alertTitle = "Your ideal bedtime is"
            alertMessage = abcde.formatted(date: .omitted, time: .shortened)
        }
        catch
        {
            alertTitle = "Error."
            alertMessage = "Sorry, there was a problem calculating your bed time."
        }
        
        showingAlert = true
    }
    
}



#Preview 
{
    ContentView()
}
