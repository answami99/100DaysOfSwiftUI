//
//  FilterListView.swift
//  CoreDataProject
//
//  Created by Aditya Narayan Swami on 08/01/22.
//

import SwiftUI

struct FilterListView: View {
    @FetchRequest var countries: FetchedResults<Country>
    init(filterOn: String, filterCharacter: String){
        _countries = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "%K beginswith %@",String(filterOn) , filterCharacter))
    }
    var body: some View {
        List {
            ForEach(countries, id: \.self) { country in
                Section(country.wrappedFullName) {
                    ForEach(country.candyArray, id: \.self) { candy in
                        Text(candy.wrappedName)
                    }
                }
            }
        }
    }
}

struct FilterListView_Previews: PreviewProvider {
    static var previews: some View {
        FilterListView(filterOn: "fullName", filterCharacter: "U")
    }
}
