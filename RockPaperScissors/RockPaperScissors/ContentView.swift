//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Aditya Narayan Swami on 13/11/21.
//

import SwiftUI
struct ContentView: View {
    @State private var options = ["rock", "paper", "scissors"]
    @State private var score = 0
    @State private var counter = 0
    @State private var selectedAnswer = ""
    @State private var finalRound = false
    @State private var blur:CGFloat = 18
    @State private var rockBlur:CGFloat = 0
    @State private var paperBlur:CGFloat = 0
    @State private var scissorsBlur:CGFloat = 0
    var randomOption = Int.random(in: 0...2)
    var body: some View {
        ZStack{
            Color("customColor")
                .shadow(radius: 10)
                .ignoresSafeArea()
            VStack{
                Text("Ready To Play")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 8)
                Spacer()
                Image(options[randomOption])
                    .blur(radius: blur)
                    .frame(width: 200, height: 200)
                    .background(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                    .shadow(radius: 8)
                Spacer()
                HStack(spacing: 10){
                    Button{
                        blur = 0
                        counter += 1
                        paperBlur = 10
                        scissorsBlur = 10
                        selectedAnswer = "rock"
                    } label:{
                        Image("rock")
                            .blur(radius: rockBlur)
                            .background(.orange)
                            .clipShape(Capsule())
                            .shadow(radius: 8)
                    }
                    Button{
                        blur = 0
                        counter += 1
                        rockBlur = 10
                        scissorsBlur = 10
                        selectedAnswer = "paper"
                    } label:{
                        Image("paper")
                            .blur(radius: paperBlur)
                            .background(.orange)
                            .clipShape(Capsule())
                            .shadow(radius: 8)
                    }
                    Button{
                        blur = 0
                        counter += 1
                        paperBlur = 10
                        rockBlur = 10
                        selectedAnswer = "scissors"
                    } label:{
                        Image("scissors")
                            .blur(radius: scissorsBlur)
                            .background(.orange)
                            .clipShape(Capsule())
                            .shadow(radius: 8)
                    }
                }
                Spacer()
                Button("Next"){
                    checkAnswer()
                    blur = 18
                    options.shuffle()
                    rockBlur = 0
                    paperBlur = 0
                    scissorsBlur = 0
                    if counter == 5{
                        finalRound = true
                    }
                }
                .alert("Final Result", isPresented: $finalRound){
                    Button("Play Again"){
                        
                        score = 0
                        counter = 0
                    }
                } message:{
                    Text("Score: \(score)")
                }
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .frame(width: 130, height: 50)
                    .background(.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .circular))
                Spacer()
            }
        }
    }
    func checkAnswer(){
        if selectedAnswer == "rock"{
            if options[randomOption] == "paper"{
                score -= 1
            }else if options[randomOption] == "scissors"{
                score += 1
            }
        }else if selectedAnswer == "paper"{
            if options[randomOption] == "scissors"{
                score -= 1
            }else if options[randomOption] == "rock"{
                score += 1
            }
        }else if selectedAnswer == "scissors"{
            if options[randomOption] == "rock"{
                score -= 1
            }else if options[randomOption] == "paper"{
                score += 1
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
