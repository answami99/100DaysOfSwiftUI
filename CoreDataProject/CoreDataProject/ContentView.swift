//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Aditya Narayan Swami on 01/01/22.
//

import SwiftUI
import CoreData
struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    @State private var filter = "fullName"
    @State private var filterCharacter = ""
    private var filters = ["fullName", "shortName"]
    private var characters = ["C", "U", "S"]
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            FilterListView(filterOn: filter, filterCharacter: filterCharacter)
            Picker("Apply filter on", selection: $filter){
                ForEach(filters, id:\.self){
                    Text($0)
                }
            }
            Picker("Character", selection: $filterCharacter){
                ForEach(characters, id: \.self){
                    Text($0)
                }
            }
            Button("Add") {
                let country1 = Country(context: moc)
                country1.fullName = "United Kingdom"
                country1.shortName = "UK"
//                country1.candy = Candy(context: moc)
                for num in 1...4{
                    let candyObject = Candy(context: moc)
                    candyObject.name = "Candy\(num)"
                    candyObject.origin = country1
                }

                try? moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
