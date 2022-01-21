//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Aditya Narayan Swami on 25/12/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: OrderClass
    var body: some View {
            Form{
                Section{
                    TextField("Name", text: $order.orderObject.name)
                    TextField("Street Name", text: $order.orderObject.streetName)
                    TextField("City", text: $order.orderObject.city)
                    TextField("Zip", text: $order.orderObject.zip)
                }
                .disableAutocorrection(true)
                Section{
                    NavigationLink{
                        CheckoutView(order: order)
                    } label: {
                        Text("Check Out")
                    }
                }
                .disabled(!order.orderObject.validAddress)
            }
            .navigationTitle("Delivery Details")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderClass())
    }
}
