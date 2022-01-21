//
//  ContentView.swift
//  BetterRest
//
//  Created by Aditya Narayan Swami on 15/11/21.
//
import CoreML
import SwiftUI

struct ContentView: View {
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffee = 1
    private var computedSleep: Date {
            let model = try! SleepCalculator(configuration: MLModelConfiguration())
            let components = Calendar.current.dateComponents([.minute, .hour], from: wakeUp)
            let hourInSeconds = (components.hour ?? 0) * 60 * 60
            let minuteInSeconds = (components.minute ?? 0) * 60
            let prediction = try! model.prediction(wake: Double(hourInSeconds+minuteInSeconds), estimatedSleep: sleepAmount ,coffee: Double(coffee))
            return wakeUp - prediction.actualSleep
    }
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    init(){
        UITableView.appearance().backgroundColor = .systemYellow
    }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    HStack{
                        Spacer()
                        Text(computedSleep.formatted(date: .omitted, time: .shortened))
                            .font(.largeTitle)
                            .shadow(radius: 2)
                        Spacer()
                    }
                    .padding(.vertical)
                    .background(.regularMaterial)
                    .clipShape(Capsule())
                    .shadow(radius: 4)
                } header: {
                    Text("Go to sleep at")
                        //.foregroundColor(.blue)
                }
                .listRowBackground(Color.yellow)
                //.shadow(radius: 1)
                
                
                Section{
                    DatePicker("Please enter the time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want to wake up")
                        //.foregroundColor(.blue)
                       // .font(.headline)
                }
                .datePickerStyle(.wheel)
                Section{
                    
                    Stepper("\(sleepAmount.formatted()) Hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .font(.callout.bold())
                } header: {
                    Text("Desired time of sleep")
                        //.foregroundColor(.blue)
                        //.font(.headline)
                }
                Section{
                    Picker("Number of coffee cups", selection: $coffee){
                        ForEach(1..<20){
                            Text($0 == 1 ? "1 Cup" : "\($0) Cups")
                        }
                    }
                        .pickerStyle(.wheel)
                } header: {
                    Text("Daily coffee intake")
                       // .foregroundColor(.bl)
                       // .font(.headline)
                }
                
                
            }
            .navigationTitle("BetterRest")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
