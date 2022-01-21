//
//  ContentView.swift
//  WeSplit
//
//  Created by Aditya Narayan Swami on 08/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var percentageTip = 20
    @FocusState private var amountSelected: Bool
    let currentCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "INR")
    let percentageTipList = [0, 10, 15, 20, 25, 30]
    var computedSplit: Double{
        let peopleCount = Double(numberOfPeople)
        let percentage = Double(percentageTip)
        let percentageAmount = checkAmount*percentage/100
        let newAmount = checkAmount + percentageAmount
        return newAmount/peopleCount
    }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Enter amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "INR"))
                        .keyboardType(.decimalPad)
                        .focused($amountSelected)
                } header: {
                    Text("Amount")
                }
                Section{
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(0..<20){
                            Text("\($0) People")
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("Number of People")
                }
                Section{
                    Picker("Percentage of Tip", selection: $percentageTip){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                } header:{
                    Text("Select Tip Percentage")
                }
                Section{
                    Text(computedSplit*Double(numberOfPeople), format: currentCurrency)
                } header :{
                    Text("Total Amount")
                }
                Section{
                    Text(computedSplit, format: currentCurrency)
                        .foregroundColor(percentageTip==0 ? .red : .primary)
                } header :{
                    Text("Amount Per Person")
                }
                
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        amountSelected = false
                    }
                }
            }
        }
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
