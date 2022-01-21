//
//  ContentView.swift
//  Animations
//
//  Created by Aditya Narayan Swami on 23/11/21.
//

import SwiftUI
struct createACard: View{
    @State private var drag = CGSize.zero
    var colorGradient: [Color]
    var body: some View{
        LinearGradient(gradient: Gradient(colors: colorGradient), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 8)
            .offset(drag)
            .gesture(
                DragGesture()
                    .onChanged{ drag = $0.translation }
                    .onEnded{_ in drag = CGSize.zero}
            )
            .animation(.interpolatingSpring(stiffness: 80, damping: 7), value: drag)
    }
}
struct ContentView: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.white
                    .ignoresSafeArea()

                VStack(spacing: 30){
                    createACard(colorGradient: [Color.yellow, Color.orange, Color.red])
                    createACard(colorGradient: [Color.teal, Color.blue, Color.purple])
                    createACard(colorGradient: [Color.yellow, Color.green])
                }
            }
                        
            
            .navigationTitle("Animation")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
