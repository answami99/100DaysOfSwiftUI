//
//  ContentView.swift
//  iExpense
//
//  Created by Aditya Narayan Swami on 30/11/21.
//

import SwiftUI


class Expenses: ObservableObject{
    init(){
        if let savedData = UserDefaults.standard.data(forKey: "items"){
            if let decodedData = try? JSONDecoder().decode([ExpenseItem].self, from: savedData){
                listOfExpenses = decodedData
                return
            }
        }
        listOfExpenses = []
    }
    @Published var listOfExpenses = [ExpenseItem]() {
        didSet{
            if let encodedData = try? JSONEncoder().encode(listOfExpenses){
                UserDefaults.standard.set(encodedData, forKey: "items")
            }
        }
    }
}
struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showAddView = false
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.listOfExpenses){ item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            HStack{
                                Text(item.type)
                                    .padding(3)
                                    .background(colorForTag(type: item.type))
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .shadow(radius: 4)
                                Spacer()
                                Text(item.date, style: .date)
                                    .font(.subheadline)
                                Spacer()
                            }
                        }
                        Spacer()
                        HStack{
                            Text("-")
                                .foregroundColor(colorForAmount(amount: item.amount))
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "INR"))
                                .foregroundColor(colorForAmount(amount: item.amount))
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button{
                    showAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddView){
                AddView(expenses: expenses)
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
    func colorForAmount(amount: Double) -> Color{
        if amount <= 50 {
            return Color.green
        }else if amount>50 && amount<=500{
            return Color.yellow
        }else{
            return Color.red
        }
    }
    func removeItems(at offsets: IndexSet){
        expenses.listOfExpenses.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
