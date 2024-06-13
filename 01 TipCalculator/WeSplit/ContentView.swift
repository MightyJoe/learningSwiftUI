//
//  ContentView.swift
//  WeSplit
//
//  Created by Joe Harrison on 2024-04-17.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 10
    @State private var useRedText = false;
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
                
                Section("TIP PERCENT") {
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }	
                    }.pickerStyle(.segmented)
                }
                
                Section ("AMMOUNT PER PERSON") {
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .foregroundStyle((tipPercentage == 0) ? .red : .primary)
                }
                Section ("TOTAL BILL"){
                    Text(totalWithTip,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))                }
            }
            .navigationTitle("Tip Calc")
            .toolbarTitleDisplayMode(.inline)
        }
    }
    
    protocol Measurement{
        var isMetric: Bool {get set}
        func MetricSize() -> Double
        func InchSize() -> Double
        func ToString() -> String
    }
    
    class MetricSize : Measurement {
        
        var isMetric: Bool
        var mm: Double
        var label: String
        
        init(isMetric: Bool, label: String, mm: Double) {
            self.isMetric = true
            self.label = label
            self.mm = mm
        }
        
        func InchSize() -> Double {
            return mm * 0.03937008
        }
        
        func MetricSize() -> Double {
            return mm
        }
        
        func ToString() -> String {
            return label
        }
    }
    
    class StandardSize : Measurement{
        var isMetric: Bool
        var sixtyFourths: Int
        
        init(isMetric: Bool, sixtyFourths: Int) {
            self.isMetric = isMetric
            self.sixtyFourths = sixtyFourths
        }
        
        func MetricSize() -> Double {
            return InchSize() / 0.03937008
        }
        
        func InchSize() -> Double {
            return Double(sixtyFourths)/64.0
        }
        
        func ToString() -> String {
            let inches: Int = sixtyFourths % 64
            
            if(inches > 0) {
                return "\(inches)"
            }
            return ""
        }
        

    }
    
//    @State private var tapCount = 0
//    @State private var name: String = "";
//    @State private var selectedColor: String = "";
//    let colors = ["Red", "Green", "Blue", "Orange", "Purple"]
    
//    var body: some View {
        
//        NavigationStack{
//            Button("Tap Count: \(tapCount)"){
//                tapCount += 1
//            }
//            Form {
//                Section{
//                    TextField("Put name here.", text: $name)
//                    Text("Yo \(name)!")
//                }
//                Section{
//                    Picker("What is your favorite color?", selection: $selectedColor){
//                        ForEach(colors, id: \.self){
//                            Text($0)
//                        }
//                    }
//                }
//                if(!name.isEmpty && !selectedColor.isEmpty){
//                    Text("So, \(name) likes \(selectedColor) eh?")
//                }
//                
//                
//
//            }.navigationTitle("SwiftUI")
//                .navigationBarTitleDisplayMode(.inline)
//        }
//    }
}

#Preview {
    ContentView() 
}
