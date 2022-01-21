//
//  AddView.swift
//  iExpense
//
//  Created by Aditya Narayan Swami on 02/12/21.
//

import SwiftUI

struct AddView: View {
//    init(){
//        UITableView.appearance().backgroundColor = .clear
//    }
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var date = Date.now
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    let types = ["Personal", "Family", "Business", "Other"]
    
    var body: some View {
        
        NavigationView{
            ZStack{
                LinearGradient(colors: [colorForTag(type: type), Color.black], startPoint: .top, endPoint: .bottom)
                    .opacity(0.35)
                    .ignoresSafeArea()
                
                HStack{
                    Spacer()
                    
                    VStack(spacing: 20){
                        Picker("Type", selection: $type){
                            ForEach(types, id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        TextField("Item", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        DatePicker("Select the date", selection: $date, displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(.wheel)
                        
                        TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "INR"))
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        Spacer()
                    }
                    //.background(.red)
                    .navigationTitle("Add New Expense")
                    .toolbar{
                        Button("Done"){
                            let item = ExpenseItem(name: name, type: type, date: date, amount: amount)
                            expenses.listOfExpenses.append(item)
                            dismiss()
                        }
                    }
                    Spacer()
                }
            }
        }
    }
    func colorForTag(type: String) -> Color{
        if type == "Family"{
            return Color.green
        }else if type == "Personal"{
            return Color.purple
        }else if type == "Business" {
            return Color.blue
        }else{
            return Color.gray
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
