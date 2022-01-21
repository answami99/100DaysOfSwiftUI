//
//  Order.swift
//  Cupcake Corner
//
//  Created by Aditya Narayan Swami on 25/12/21.
//

import Foundation
import SwiftUI

class Order: ObservableObject, Codable{
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var validAddress: Bool {
        if name.isEmpty || streetName.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }else if Int(zip) == nil{
            return false
        }
        return true
    }
    
    var cost: Double{
        var price = Double(quantity)*2
        
        price += Double(type)/2
        //This is just to complicate our price some more, like first type will have no added cost, for second one will .50 addition and so on.
        
        if extraFrosting{
            price += Double(quantity)
        }
        if addSprinkles{
            price += Double(quantity)/2
        }
        
        return price
    }
    
    @Published var type = 0
    @Published var quantity = 3
    @Published var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetName = ""
    @Published var city = ""
    @Published var zip = ""
    
    enum CodingKeys: CodingKey{
        case type, quantity, specialRequestEnabled, extraFrosting, addSprinkles, name, streetName, city, zip
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(specialRequestEnabled, forKey: .specialRequestEnabled)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(streetName, forKey: .streetName)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
        
        
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        specialRequestEnabled = try container.decode(Bool.self, forKey: .specialRequestEnabled)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        streetName = try container.decode(String.self, forKey: .streetName)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    init() {}
}
