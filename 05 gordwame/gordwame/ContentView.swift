//
//  ContentView.swift
//  gordwame
//
//  Created by Joe Harrison on 2024-05-28.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingMessage = false
    @State private var score: Int = 0
    
    var body: some View {
        NavigationStack 
        {
            HStack{
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Text("Score: \(score)")
                Spacer()
            }
            List {
                Section ("Using the letters in \(rootWord)"){
                    TextField("Make a word", text: $newWord).textInputAutocapitalization(.never)
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                            Spacer()
                            Text("\(getScoreForOneWord(word: word))")
                        }
                    }
                }
            }.navigationTitle(rootWord)
                .onSubmit (addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingMessage, actions: {
                }, message: {
                    Text(errorMessage)
                })
                .toolbar{
                    Button( "Restart Game", action: startGame)
                }
        }
    }
    
    func startGame()
    {
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt")
        {
            if let startWords = try? String(contentsOf: startWordsUrl)
            {
                withAnimation{
                    let allWords = startWords.components(separatedBy: "\n")
                    rootWord = allWords.randomElement() ?? "crossword"
                    usedWords.removeAll()
                    score = 0
                }
                    return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else{ return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible with word given", message: "You cannot spell that word with the letters given in the word: '\(rootWord)'!")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not found in dictionary.", message: "This word isn't real.")
            return
        }
        guard isNotRootWord(word: answer) else {
            wordError(title: "Really...", message: "You cannot use the word we gave you in the first place.")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0) //so that things entered are added at the top. Let's users see what has been done.
            newWord = ""
            score = calculateScore()
        }
    }
    
    func calculateScore() -> Int
    {
        var answer = 0
        for word in usedWords
        {
            answer += getScoreForOneWord(word: word)
        }
        return answer
    }
    
    func getScoreForOneWord(word: String) -> Int
    {
        var answer: Int = 0
        
        answer += word.count * word.count
        
        return answer
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool 
    {
        var tempWord = rootWord //copy
        
        for letter in word 
        {
            if let pos = tempWord.firstIndex(of: letter)
            {
                tempWord.remove(at: pos)
            }
            else
            {
                return false
            }
        }
        return true
    }
    
    func wordError(title: String, message: String)
    {
        errorTitle = title;
        errorMessage = message
        showingMessage = true
    }
    
    /**
     Scan for misspelled word
     */
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }

    func isNotRootWord(word: String) -> Bool {
        let copyOfRoot = rootWord
        return (word.lowercased() != copyOfRoot.lowercased())
    }
}



#Preview {
    ContentView()
}
