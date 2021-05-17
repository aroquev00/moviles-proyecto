//
//  QuizSideMenuView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 06/05/21.
//

import SwiftUI

struct QuizSideMenuView: View {
    @Binding var question: QuizQuestion
    @Binding var quiz: Quiz
    let resetQuestion: () -> Void
    @Binding var incorrectNum: Int
    @Binding var alertVisible: Bool
    @Binding var activeAlert: ActiveAlert
    
    var body: some View {
        GeometryReader { sideGeo in
            let switchesVerticalPadding: CGFloat = sideGeo.size.height * 0.03
            VStack {
                Button(action: resetQuestion, label: {
                    HStack {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.largeTitle)
                        Text("Reiniciar")
                            .font(Font.custom("Bangers-Regular", size: sideGeo.size.width * 0.15))
                            .tracking(2)
                    }
                    .frame(width: sideGeo.size.width)
                    .padding(EdgeInsets(top: switchesVerticalPadding, leading: 0, bottom: switchesVerticalPadding, trailing: 0))
                    .foregroundColor(Color.mainTitleTextForeground)
                    .background(Color.resetButtonBackground)
                    .cornerRadius(10)
                })
                // MARK: Ruler switch
                HStack {
                    Spacer()
                    Toggle("",isOn: $question.simulator.rulerEnabled)
                        .labelsHidden()
                    Spacer()
                    Image(systemName: "ruler.fill")
                        .foregroundColor(Color.mainButtonBackground)
                        .background(
                            Color.mainTitleTextForeground
                                .scaleEffect(CGSize(width: 0.7, height: 0.6)))
                        .font(.largeTitle)
                    Spacer()
                }
                .frame(width: sideGeo.size.width)
                .padding(EdgeInsets(top: switchesVerticalPadding, leading: 0, bottom: switchesVerticalPadding, trailing: 0))
                .background(Color.resetButtonBackground)
                .cornerRadius(10)
                
                // MARK: Check button
                Button(action: {
                    question.checkAnswer()
                    addPoints()
                    
                }) {
                    Text("Revisar")
                        .font(Font.custom("Bangers-Regular", size: sideGeo.size.width * 0.25))
                        .tracking(2)
                        .frame(width: sideGeo.size.width)
                        .padding(EdgeInsets(top: switchesVerticalPadding, leading: 0, bottom: switchesVerticalPadding, trailing: 0))
                        .foregroundColor(Color.mainTitleTextForeground)
                        .background(Color.mainButtonBackground)
                        .cornerRadius(10)
                        
                }
                
                Spacer()
                VStack {
                    Image(uiImage: UIImage(named: question.simulator.selectedSprite!.imageURL)!)
                        .resizable()
                        .scaledToFit()
                    //Text(String(format: "%.2f", question.simulator.selectedSprite!.weight) + " kg")
                    Text(String(format: (floor(question.simulator.selectedSprite!.weight) == question.simulator.selectedSprite!.weight ? "%.0f" : "%.2f"), question.simulator.selectedSprite!.weight) + " kg")
                        .font(Font.custom("Bangers-Regular", size: sideGeo.size.width * 0.2))
                        .foregroundColor(.orange)
                }
            }
        }
    }
    
    func addPoints() {
        if question.answerStatus == .correct {
            quiz.points += 1
            activeAlert = .second
        }
        else if question.answerStatus == .incorrect {
            if incorrectNum != 3 { incorrectNum += 1 }
            if incorrectNum == 3 {
                activeAlert = .third
            }
            else {
                activeAlert = .first
            }
        }
        alertVisible = true
    }
}

struct QuizSideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            QuizSideMenuView(question: .constant(PlacingQuestion(level: 1)), quiz: .constant(Quiz(level: 1)), resetQuestion: {}, incorrectNum: .constant(0), alertVisible: .constant(false), activeAlert: .constant(.first))
        }
    }
}
