//
//  ContentView.swift
//  Edutainment
//
//  Created by Aditya Narayan Swami on 28/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var numberForPractise = 2
    @State private var selectedRange = 10
    @State private var startGame = false
    @State private var userAnswer = ""
    @State private var randomNumber = 2
    @State private var score = 0
    var range = [ 5, 10, 15, 20, 25, 30 ]
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section{
                        Stepper("Number: \(numberForPractise)", value: $numberForPractise, in: 2...12)
                    } header: {
                        Text("Select a number")
                    }
                    Section{
                        Picker("Select a Range", selection: $selectedRange){
                            ForEach(range, id: \.self){
                                Text("\($0)")
                                
                            }
                        }
                            .pickerStyle(.wheel)
                    } header:{
                        Text("Pick the range")
                    }
                    Section{
                        Text("What is \(numberForPractise) x \(randomNumber)")
                        TextField("Enter the answer", text: $userAnswer)
                        HStack{
                            Spacer()
                            Button("Submit"){
                                score = Int(userAnswer) == randomNumber*numberForPractise ? score+1 : score-1
                                randomNumber = Int.random(in: 1...selectedRange)
                                userAnswer = ""
                            }
                            Spacer()
                        }
                    }
                    
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Edutainment")
                
                Text("Score: \(score)")
                    .font(.title)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
