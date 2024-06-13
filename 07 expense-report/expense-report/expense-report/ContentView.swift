//
//  ContentView.swift
//  expense-report
//
//  Created by Joe Harrison on 2024-06-03.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable  {
    var id = UUID() //Identifiable requires this.
    let name: String
    let type: String
    let amount: Double

}

@Observable
class Expenses {
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items)
            {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View 
{
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View
    {
        
        NavigationStack
        {
            List{
                Section("Personal"){
                    ForEach(expenses.items, id: \.id)
                    { item in
                        if(item.type == "Personal")
                        {
                        HStack{
                            VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(getColor(amount: item.amount))
                                    Text(item.type).foregroundStyle(getColor(amount: item.amount))
                            }
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        }
                    }//ForEach
                    .onDelete(perform: removeItems)
                    HStack {
                        Text("Total")
                        Spacer()
                        Text(getAmount(itemType: "Personal", list: expenses.items), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
                Section("Business"){
                    ForEach(expenses.items, id: \.id)
                    { item in
                        if(item.type == "Business")
                        {
                        HStack{
                            VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(getColor(amount: item.amount))
                                    Text(item.type).foregroundStyle(getColor(amount: item.amount))
                            }
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        }
                    }//ForEach
                    .onDelete(perform: removeItems)
                    HStack {
                        Text("Total")
                        Spacer()
                        Text(getAmount(itemType: "Business", list: expenses.items), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
            }//List
            .navigationTitle("Expense Report")
            .toolbar
            {
                Button("Add Expense", systemImage: "plus")
                {
                    showingAddExpense = true
                }//button
                .sheet(isPresented: $showingAddExpense) 
                {
                    AddView(expenses: expenses)
                }//sheet
            }//toolbar
        }//navstack
    }//some View
    func removeItems(at offsets: IndexSet)
    {
        expenses.items.remove(atOffsets: offsets)
    }//removeItems
    
    ///Gets the color text should be based on value.
    func getColor(amount: Double) -> Color{
        if(amount < 0.0)
        {
            return .red
        }
        if(amount == 0.0)
        {
            return .gray
        }
        if(amount > 0 && amount < 20.0)
        {
            return .brown
        }
        else if(amount >= 20.0 && amount < 100.0)
        {
            return .green
        }
        else
        {
            return .purple
        }
    }
    
    func getAmount(itemType: String, list: [ExpenseItem]) -> Double {
        var tally: Double = 0.0
        
        let range = 0 ..< list.count
        
        for index in range {
            if(list[index].type == itemType)
            {
                tally += list[index].amount
            }
        }
        return tally
    }
    
}//ContentView
    
    

#Preview {
    ContentView()
}
