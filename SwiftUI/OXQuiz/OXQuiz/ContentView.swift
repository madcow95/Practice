//
//  ContentView.swift
//  OXQuiz
//
//  Created by MadCow on 2024/4/15.
//

import SwiftUI

struct ContentView: View {
    
    @State private var firstNum: Int = Int.random(in: 1...9)
    @State private var secondNum: Int = Int.random(in: 1...9)
    @State private var randomBool: Bool = Bool.random()
    @State private var correctCount: Int = 0
    @State private var wrongCount: Int = 0
    // MARK: Todo -> enum으로 바꿔보기
    @State private var randomSymbol: String = ["+", "-", "X", "÷"].randomElement()!
    
    var body: some View {
        VStack(spacing: 100) {
            Text("다음 수식은 맞을까요?")
                .font(.title)
                .bold()
            
            let answer = getAnswer(first: firstNum,
                                   second: secondNum,
                                   randomSymbol: randomSymbol,
                                   randomBool: randomBool)
            Text("\(firstNum) \(randomSymbol) \(secondNum) = \(answer)")
            
            HStack(spacing: 30) {
                Button {
                    selectCorrect()
                    reloadNumbers()
                } label: {
                    HStack {
                        Image(systemName: "checkmark.diamond.fill")
                            .resizable()
                            .scaledToFit()
                        
                        Text("맞음")
                    }
                    .foregroundStyle(.green)
                }
                
                Button {
                    selectWrong()
                    reloadNumbers()
                } label: {
                    HStack {
                        Image(systemName: "xmark.diamond")
                            .resizable()
                            .scaledToFit()
                        
                        Text("틀림")
                    }
                    .foregroundStyle(.red)
                }
            }
            .frame(height: 50)
            
            HStack(spacing: 30) {
                Text("\(correctCount)개 맞춤")
                Text("\(wrongCount)개 틀림")
            }
            
            Button {
                reloadGame()
            } label: {
                Text("카운트 초기화")
            }
        }
        .padding()
        .font(.title)
        .bold()
    }
    
    func getAnswer(first: Int, second: Int, randomSymbol: String, randomBool: Bool) -> String {
        var answer: Float = 0
        var format: String = "%.0f"
        switch randomSymbol {
        case "+":
            answer = Float(firstNum + secondNum)
        case "-":
            answer = Float(firstNum - secondNum)
        case "X":
            answer = Float(firstNum * secondNum)
        case "÷":
            format = "%.2f"
            answer = Float(firstNum) / Float(secondNum)
        default:
            answer = 0
        }

        return String(format: format, randomBool ? answer : answer - 1)
    }
    
    // MARK: 더 나은 방법을 찾아볼것
    func reloadNumbers() {
        firstNum = Int.random(in: 1...9)
        secondNum = Int.random(in: 1...9)
        randomSymbol = ["+", "-", "X", "÷"].randomElement()!
        randomBool = Bool.random()
    }
    
    func reloadGame() {
        reloadNumbers()
        correctCount = 0
        wrongCount = 0
    }
    
    func selectCorrect() {
        if randomBool {
            correctCount += 1
        } else {
            wrongCount += 1
        }
    }
    
    func selectWrong() {
        if randomBool {
            wrongCount += 1
        } else {
            correctCount += 1
        }
    }
}

#Preview {
    ContentView()
}
