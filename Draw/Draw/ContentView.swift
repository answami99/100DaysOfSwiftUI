//
//  ContentView.swift
//  Draw
//
//  Created by Aditya Narayan Swami on 15/12/21.
//



import SwiftUI
struct ContentView: View {
    var computedChange: UnitPoint{
        return UnitPoint(x: change, y: change)
    }
    @State private var change = 0.0
    var body: some View{
        VStack{
            Rectangle()
                .fill(LinearGradient(colors: [.yellow,.blue,.pink,.purple], startPoint: computedChange, endPoint: .bottomTrailing))
                .frame(width: 300, height: 200)
                .padding(.horizontal)
            Slider(value: $change)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
