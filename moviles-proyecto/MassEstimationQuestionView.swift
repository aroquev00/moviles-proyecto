//
//  MassEstimationQuestionView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI

struct MassEstimationQuestionView: View {
    @State var question: MassEstimationQuestion
    @Binding var quiz: Quiz
    
    @State var incorrectNum = 0
    @State var alertVisible: Bool = false
    @State var activeAlert: ActiveAlert = .first
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack(spacing: 0.0) {
                    VStack {
                        Text("¿Cuál es la masa de \(question.questionSprite!.name)?")
                        SimulatorView(simulator: $question.simulator)
                        Text(String(format: "%.0f", question.answerWeight))
                        Slider(value: $question.answerWeight, in: 0...100, step: 1.0, minimumValueLabel: Text("0"), maximumValueLabel: Text("100")) {
                            Text("Masa de \(question.questionSprite!.name)")
                        }
                    }
                    .frame(width: geo.size.width * 0.8)
                    
                    // MARK: - Side menu
                    QuizSideMenuView(question: $question.asQuizQuestion, quiz: $quiz, resetQuestion: {
                        question = quiz.questions[quiz.currentQuestion] as! MassEstimationQuestion
                    }, incorrectNum: $incorrectNum, alertVisible: $alertVisible, activeAlert: $activeAlert)
                        .frame(width: geo.size.width * 0.19)
                }
                
                //Triggers QuizAlertView when answer is checked
                if alertVisible {
                    QuizAlertView(alertVisible: $alertVisible, activeAlert: $activeAlert, quiz: $quiz, question: $question.asQuizQuestion)
                        .frame(width: geo.size.width/2, height: geo.size.height / 4, alignment: .center)
                }
                
            }
        }
    }
}

struct MassEstimationQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            MassEstimationQuestionView(question: MassEstimationQuestion(level: 1), quiz: .constant(Quiz(level: 1)))
        }
    }
}
