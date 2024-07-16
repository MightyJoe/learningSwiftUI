//
//  MainView.swift
//  P10 Cupcake Corner
//
//  Created by Joe Harrison on 2024-07-09.
//

import SwiftUI

struct MainView: View 
{
    @State private var order = Order()
    
    var body: some View 
    {
        NavigationStack
        {
            Form
            {
                Section
                {
                    Picker("Select your Cake type", selection: $order.type)
                    {
                        ForEach(Order.types.indices, id: \.self)
                        {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20 )
                }
                Section {
                    
                    
                    Toggle("Any special requests?", isOn:
                            $order.specialRequestEnabled.animation())
                    
                    if (order.specialRequestEnabled) {
                        Toggle( "Add extra frosting", isOn: $order.extraFrosting)
                        Toggle( "Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink ("Delivery details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview 
{
    MainView()
}
