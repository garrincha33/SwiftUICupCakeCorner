//
//  CheckoutView.swift
//  SwiftUICupCakeCorner
//
//  Created by Richard Price on 09/02/2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
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
                
                Button("place order", action: {})
                    .padding()
            }
        }.navigationTitle("Check Out")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
            .previewLayout(.sizeThatFits)
    }
}
