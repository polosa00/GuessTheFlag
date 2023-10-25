//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Александр Полочанин on 24.10.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var score = 0
    
    var body: some View {
        ZStack {
            //            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
           
            VStack{
                Spacer()
                Text("Lets start to play")
                    .foregroundStyle(.white)
                    .font(.title.weight(.heavy))
                    
                
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.black)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .cornerRadius(50)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .cornerRadius(25)
                .padding()
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.weight(.heavy))
                Spacer()
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue") {
                    nextQuestion()
                }
            } message: {
                Text("Your score is \(score)")
                
            }
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 2
            
        } else {
            scoreTitle = "Wrong"
            score -= 3
        }
        showingScore = true
    }
    
    func nextQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
    


    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
