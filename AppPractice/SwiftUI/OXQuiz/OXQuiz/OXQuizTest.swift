//
//  OXQuizTest.swift
//  OXQuiz
//
//  Created by MadCow on 2024/4/15.
//

import SwiftUI

enum MathEnum: String, CaseIterable {
    case add = "+"
    case minus = "-"
    case divide = "/"
    case multiply = "X"
}

struct OXQuizTest: View {
    @State private var firstNum: Int = Int.random(in: 1...9)
    @State private var secondNum: Int = Int.random(in: 1...9)
    @State private var randomBool: Bool = Bool.random()
    @State private var correctCount: Int = 0
    @State private var wrongCount: Int = 0
    @State private var randomMath: MathEnum = MathEnum.allCases.randomElement()!
    
    var body: some View {
        VStack {
            Text("다음 수식은 맞을까요?")
                .font(.title)
                .bold()
            
            Spacer()
            
            let answer = getAnswer(first: firstNum,
                                   second: secondNum,
                                   randomMath: randomMath,
                                   randomBool: randomBool)
            Text("\(firstNum) \(randomMath) \(secondNum) = \(answer)")
                .font(.title)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    self.selectCorrect()
                } label: {
                    HStack {
                        Image(systemName: "checkmark.diamond.fill")
                            .resizable()
                            .scaledToFit()
                        
                        Text("맞음")
                    }
                    .foregroundStyle(.green)
                }
                
                Spacer()
                
                Button {
                    self.selectWrong()
                } label: {
                    HStack {
                        Image(systemName: "xmark.diamond")
                            .resizable()
                            .scaledToFit()
                        
                        Text("틀림")
                    }
                    .foregroundStyle(.red)
                }
                
                Spacer()
            }
            .frame(height: 50)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Text("\(correctCount)개 맞춤")
                    .font(.title)
                
                Spacer()
                
                Text("\(wrongCount)개 틀림")
                    .font(.title)
                
                Spacer()
            }
            
            Spacer()
            
            Button {
                self.reloadGame()
            } label: {
                Text("카운트 초기화")
                    .font(.title)
            }
        }
        .padding()
    }
    
    func getAnswer(first: Int, second: Int, randomMath: MathEnum, randomBool: Bool) -> String {
        var answer: Float = 0
        var format: String = "%.0f"
        switch randomMath {
        case .add:
            answer = Float(firstNum + secondNum)
        case .minus:
            answer = Float(firstNum - secondNum)
        case .multiply:
            answer = Float(firstNum * secondNum)
        case .divide:
            format = "%.2f"
            answer = Float(firstNum) / Float(secondNum)
        }
        return String(format: format, randomBool ? answer : answer - 1)
    }
    
    // MARK: 더 나은 방법을 찾아볼것
    func reloadFirstAndSecondNum() {
        firstNum = Int.random(in: 1...9)
        secondNum = Int.random(in: 1...9)
        self.randomMath = MathEnum.allCases.randomElement()!
        self.randomBool = Bool.random()
    }
    
    func reloadGame() {
        reloadFirstAndSecondNum()
        correctCount = 0
        wrongCount = 0
    }
    
    func selectCorrect() {
        if randomBool {
            correctCount += 1
        } else {
            wrongCount += 1
        }
        reloadFirstAndSecondNum()
    }
    
    func selectWrong() {
        if randomBool {
            wrongCount += 1
        } else {
            correctCount += 1
        }
        reloadFirstAndSecondNum()
    }
}

#Preview {
    OXQuizTest()
}
