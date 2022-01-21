//
//  ContentView.swift
//  TimeConversion
//
//  Created by Aditya Narayan Swami on 09/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var currentUnit = "Seconds"
    @State private var conversionUnit = "Seconds"
    @State private var enteredTime = 0.0
    @FocusState private var keyboardFocus: Bool

    var middleMan: Double {
        if currentUnit == "Seconds"{
            return enteredTime
        }else if currentUnit == "Minutes"{
            return enteredTime*60
        }else if currentUnit == "Hours"{
            return enteredTime*60*60
        }else{
            return enteredTime*60*60*24
        }
    }
    var convertedTime: Double{
        if conversionUnit == "Seconds"{
            return middleMan
        }else if conversionUnit == "Minutes"{
            return middleMan/60
        }else if conversionUnit == "Hours"{
            return middleMan/3600
        }else{
            return middleMan/(3600*24)
        }
    }
    let units = ["Seconds", "Minutes", "Hours", "Days"]
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select Current Unit",selection: $currentUnit){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Select Current Unit")
                }
                Section{
                    TextField("Enter The \(currentUnit)", value: $enteredTime, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($keyboardFocus)
                } header: {
                    Text("Enter The \(currentUnit)")
                }
                Section{
                    Picker("Select Conversion Unit", selection: $conversionUnit){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Select Conversion Unit")
                }
                Section{
                    Text("\(convertedTime.formatted()) \(conversionUnit)")
                }
            }
            .navigationTitle("Time Converter")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        keyboardFocus = false
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
