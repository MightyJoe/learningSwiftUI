//
//  Order.swift
//  P10 Cupcake Corner
//
//  Created by Joe Harrison on 2024-07-09.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
        case _specialRequestEnabled = "specialRequestEnabled"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate"]
    
    var type = 0
    var quantity = 3
    
    var name = UserDefaults.standard.string(forKey: "name") ?? "" 
    {
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    var streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
    {
        didSet {
            UserDefaults.standard.set(streetAddress, forKey: "streetAddress")
        }
    }
    var city = UserDefaults.standard.string(forKey: "city") ?? ""
    {
        didSet {
            UserDefaults.standard.set(city, forKey: "city")
        }
    }
    var zip = UserDefaults.standard.string(forKey: "zip") ?? ""
    {
        didSet {
            UserDefaults.standard.set(zip, forKey: "zip")
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    var specialRequestEnabled = false {
        didSet {
            if (specialRequestEnabled == false) {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var hasValidAddress: Bool {
        if(trim(name).isEmpty || trim(streetAddress).isEmpty || trim(city).isEmpty || trim(zip).isEmpty)
        {
            return false
        }
        
        return true
    }
    
    func trim(_ input: String) -> String {
        return input.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal (quantity) * 2
        
        //complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if (extraFrosting) {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}
