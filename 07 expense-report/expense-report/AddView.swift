//
//  AddView.swift
//  expense-report
//
//  Created by Joe Harrison on 2024-06-05.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0

    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Ammount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }		
            .navigationTitle("Add New Expense")
            .toolbar{
                Button("Save")
                {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
            Button("Cancel"){
                dismiss()
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
