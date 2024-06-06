//
//  ContentView.swift
//  sockit
//
//  Created by Joe Harrison on 2024-04-24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 10
    @FocusState private var ammountIsFocused
    
    let tipPercentages = [10,15,20,0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 1)
        let tipSelection = Double(tipPercentage)
        let tipValue: Double = (checkAmmount / 100.0) * tipSelection
        return (checkAmmount + tipValue) / peopleCount
    }
    
    var totalWithTip: Double{
        let tipSelection = Double(tipPercentage)
        let tipValue: Double = (checkAmmount / 100.0) * tipSelection
        return (checkAmmount + tipValue)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Ammount",
                              value: $checkAmmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($ammountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople)
                    {
                        ForEach(1..<100) {
                            if($0 == 1)
                            {
                                Text("1 Person")
                            }
                            else{
                                Text("\($0) People")
                            }
                        }
                    }
                }//.pickerStyle(.navigationLink)
                
                Section("TIP AMMOUNT") {
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section ("AMMOUNT PER PERSON") {
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section ("TOTAL BILL"){
                    Text(totalWithTip,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))                }
            }
            .navigationTitle("Tip Calc")
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
