//
//  OrderStruct.swift
//  Cupcake Corner
//
//  Created by Aditya Narayan Swami on 26/12/21.
//

import Foundation
struct OrderStruct: Codable{
    var types: [String] = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
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
    
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
       didSet{
           if specialRequestEnabled == false{
               extraFrosting = false
               addSprinkles = false
           }
       }
   }
    var extraFrosting = false
    var addSprinkles = false
   
    var name = ""
    var streetName = ""
    var city = ""
    var zip = ""
   
}
