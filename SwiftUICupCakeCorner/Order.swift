//
//  Order.swift
//  SwiftUICupCakeCorner
//
//  Created by Richard Price on 09/02/2022.
//

import SwiftUI

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequirementsEnabled = false {
        didSet {
            if specialRequirementsEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false  
}
