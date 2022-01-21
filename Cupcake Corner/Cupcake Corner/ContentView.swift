//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Aditya Narayan Swami on 24/12/21.
//

import SwiftUI
class OrderClass: ObservableObject, Codable{
    @Published var orderObject = OrderStruct()
    
    enum CodingKeys: CodingKey{
        case orderObject
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderObject = try container.decode(OrderStruct.self, forKey: .orderObject)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderObject, forKey: .orderObject)
    }
    init() {}
}
struct ContentView: View {
    @StateObject private var order = OrderClass()
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type: ", selection: $order.orderObject.type){
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    .pickerStyle(.automatic)
                    Stepper("Number of Cakes: \(order.orderObject.quantity)", value: $order.orderObject.quantity, in: 3...20)
                }
                Section{
                    Toggle("Any special requests?", isOn: $order.orderObject.specialRequestEnabled.animation())
                    if order.orderObject.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.orderObject.extraFrosting)
                        Toggle("Add extra sprinkes", isOn: $order.orderObject.addSprinkles)
                    }
                }
                Section{
                    NavigationLink{
                        AddressView(order: order)
                    } label: {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
