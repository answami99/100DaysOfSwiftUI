//
//  ContentView.swift
//  WordScramble
//
//  Created by Aditya Narayan Swami on 19/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false
    @State private var score = 0
    
    var body: some View {
            VStack{
                    HStack{
                        Spacer()
                        Text(rootWord)
                            .font(.largeTitle.bold())
                            .frame(width: 230, height: 230)
                            .background(.regularMaterial)
                            .clipShape(Capsule())
                            .shadow(radius: 8)
                        Spacer()
                    }
                    .padding(15)
                    .background(.blue)
                List{
                    Section{
                        TextField("Enter the word", text: $newWord)
                            .autocapitalization(.none)
                    }
                    .padding()
                    Section{
                        ForEach(usedWords, id: \.self){ word in
                            HStack{
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .onSubmit(checkNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showError){
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(errorMessage)
                }
                HStack{
                    Spacer()
                    Text("Score: \(score)")
                        //.shadow(radius: 2)
                        .font(.title.bold())
                    Spacer()
                }
            }
            .background(.blue)
//            .toolbar{
//                Button("Restart", action: startGame)
//                    .foregroundColor(.red)
        }
        
        //.toolbar
    func startGame(){
        usedWords = [String]()
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: ".txt"){
            if let dataIntoString = try? String(contentsOf: fileURL){
                let allwords = dataIntoString.components(separatedBy: "\n")
                rootWord = allwords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Couldn't load the file from bundle")
            
    }
    func checkNewWord(){
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard word.count > 0 else { return }
        
        guard isShort(word: word) else{
            wordError(title: "Too Short", message: "Please enter word with more than 3 letters")
            return
        }
        guard isStartOf(word: word) else{
            wordError(title: "It is start of \(rootWord)", message: "BURH! Be Creative")
            return
        }
        guard isOriginal(word: word) else {
            wordError(title: "Not Original", message: "\(word) has been already used")
            return
        }
        guard isPossible(word: word) else{
            wordError(title: "Not possible", message: "\(word) is not possible from \(rootWord)")
            return
        }
        guard isReal(word: word) else{
            wordError(title: "Not Real", message: "\(word) doesn't exist in dictionary")
            return
        }
        
        withAnimation{
            usedWords.insert(word, at: 0)
        }
        score += word.count
        newWord = ""
    }
    func isShort(word: String) -> Bool{
        word.count>3
    }
    func isStartOf(word: String) -> Bool{
        !(word == rootWord.substring(to: word.endIndex))
    }
    func isOriginal(word: String) -> Bool{
        !usedWords.contains(word)
    }
    func isPossible(word: String) -> Bool{
        var tempWord = rootWord
        for i in word{
            if let pos = tempWord.firstIndex(of: i){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
