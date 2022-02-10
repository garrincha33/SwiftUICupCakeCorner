//
//  CheckoutView.swift
//  SwiftUICupCakeCorner
//
//  Created by Richard Price on 09/02/2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                Text("your total is\(order.cost, format: .currency(code: "USD")))")
                
                Button("place order") {
                    Task {
                        await placeOrder()
                    }
                   
                }
                    .padding()
            }
        }.navigationTitle("Check Out")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thanks You", isPresented: $showingConfirmation) {
                Button("OK") {}
            } message: {
                Text(confirmationMessage)
            }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("failed to encode")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodeOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order of \(decodeOrder.quantity)x \(Order.types[decodeOrder.type].lowercased()) cupcakes is on its way"
            showingConfirmation = true
            
        } catch {
            print("checkout failed")
        }
        
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
            .previewLayout(.sizeThatFits)
    }
}
