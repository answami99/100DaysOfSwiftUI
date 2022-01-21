//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Aditya Narayan Swami on 11/11/21.
//

import SwiftUI

struct gridView<Content: View> : View{
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    var body : some View{
        VStack{
            ForEach(0..<rows, id:\.self){ row in
                HStack{
                    ForEach(0..<columns, id:\.self){ column in
                        content(row, column)
                    }
                }
            }
        }
    }
}
struct ContentView: View {
    var body: some View {
        gridView(rows: 4, columns: 4){ row, column in
            HStack{
                Image(systemName: "person.circle.fill")
                Text("(\(row), \(column))")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
