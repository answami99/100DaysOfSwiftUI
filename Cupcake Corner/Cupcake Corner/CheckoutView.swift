//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Aditya Narayan Swami on 25/12/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: OrderClass
    @State private var confirmationMessage = ""
    @State private var alertTitle = ""
    @State private var confirmationAlert = false
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                Text("Your total is \(order.orderObject.cost, format: .currency(code: "INR"))")
                    .font(.title)
                Button("Place Order"){
                    Task{
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $confirmationAlert){
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
    }
    func placeOrder() async {
        guard let encodedData = try? JSONEncoder().encode(order) else{
            print("Couldn't encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do{
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedData)
            
            let decodedData = try JSONDecoder().decode(OrderClass.self, from: data)
            alertTitle = "Thank You!"
            confirmationMessage = "You order for \(decodedData.orderObject.quantity) x \(Order.types[decodedData.orderObject.type].lowercased()) cake is on the way!"
            confirmationAlert = true
        }catch{
            print("Couldn't fetch the details")
            alertTitle = "Error"
            confirmationMessage = "Couldn't fetch order details please try again later!"
            confirmationAlert = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: OrderClass())
    }
}
