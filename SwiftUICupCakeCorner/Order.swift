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
    
    @Published var name = ""
    @Published var streetAdress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAdress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += (Double(type) / 2 )
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
}
