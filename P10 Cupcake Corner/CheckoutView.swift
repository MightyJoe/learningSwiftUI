//
//  CheckoutView.swift
//  P10 Cupcake Corner
//
//  Created by Joe Harrison on 2024-07-17.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var httpErrorHappened = false
    @State private var httpErrorReason = "Could not reach website."
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                           scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order", action: {
                    Task {
                        await placeOrder()
                    }
                })
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation)
        {
            Button("OK"){}
        } message: {
            Text( httpErrorHappened ? httpErrorReason : confirmationMessage)
            
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the way!"
            showingConfirmation = true
        } catch {
            let errorString = "Check out failed:\n \(error.localizedDescription)"
            httpErrorReason = errorString
            httpErrorHappened = true
            showingConfirmation = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
