//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Aditya Narayan Swami on 09/11/21.
//

import SwiftUI
struct imageView: View{
    var image: String
    var body: some View{
        Image(image)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 10)
    }
}
struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var finalRound = false
    @State private var score = 0
    @State private var counter = 0
    @State private var buttonTap = 0.0
    @State private var buttonTapped = false
    
    @State private var angle = Angle.degrees(0)
    @State private var offset = CGSize.zero
    @State private var opacity = 1.0
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 600)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess The Flag")
                    .prominentTitle()
                
                VStack(spacing: 15){
                    Spacer()
                    ZStack{
                        Text("")
                            .frame(width: 250, height: 80)
                            .background(.ultraThinMaterial)
                        VStack{
                            Text("Tap the Flag")
                                .foregroundColor(.black)
                                .font(.subheadline.weight(.heavy))
                            Text(countries[correctAnswer])
                                .foregroundColor(.white)
                                .font(.largeTitle.weight(.semibold))
                        }
                        .shadow(radius:5)
                    }
                    .clipShape(RoundedRectangle(cornerRadius:20))
                    .shadow(radius:5)
                    Spacer()
                    VStack(spacing: 15){
                        ForEach(0..<3){ i in
                            Button{
                                        buttonTap += 360
                                        buttonTapped(i)

                            } label: {
                                imageView(image:countries[i])
                            }
                            
                            .rotation3DEffect(i == self.correctAnswer ? self.angle : .degrees(0), axis: (x: 0, y: 1, z: 0))
                            .offset(self.offset)
                            .opacity(i != self.correctAnswer ? self.opacity : 1)
                            
                        }
                        .alert(scoreTitle, isPresented: $showingScore){
                            Button("Continue", action: askQuestion)
                        } message: {
                            Text("Score: \(score)")
                        }
                        .alert("Final Result", isPresented: $finalRound){
                            Button("Restart", action: askQuestion)
                        } message: {
                            Text("Final Score: \(score)")
                        }
                        
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 40)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(radius: 10)
                    
    
                    
                    Spacer()
                }
    
                Text("Score: \(score)")
                    .foregroundStyle(.secondary)
                    .font(.title.bold())
            }
        }
    }
    func askQuestion(){
        if counter == 8{
            score = 0
            counter = 0
            
        }
        self.opacity = 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func buttonTapped(_ number: Int){
        
        counter += 1
        if number == correctAnswer{
            scoreTitle = "Correct"
            score+=1
            withAnimation {
                          self.angle += .degrees(360)
            }
            self.angle = .degrees(0)
        }else{
            scoreTitle = "Wrong! that's the flag of \(countries[number])"
            score-=1
            self.offset = CGSize(width: 10, height: 0)
            withAnimation(.interpolatingSpring(stiffness: 2000, damping: 10)) {
                    self.offset = .zero
            }
            
        }
        withAnimation(.easeInOut) {
                    self.opacity = 0.25
        }
        if counter == 8 {
            finalRound = true
        }else{
            showingScore = true
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}
