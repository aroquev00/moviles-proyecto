//
//  QuizView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var level: Int
    @State var quiz: Quiz = Quiz(level: 0) // Placeholder value at start
    
    var body: some View {
        ZStack {
            Color.whiteBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                if quiz.questions.count > 0 { // To wait for real quiz to be assigned
                    switch quiz.questions[quiz.currentQuestion] {
                    case is PredictionQuestion:
                        PredictionQuestionView(question: quiz.questions[quiz.currentQuestion] as! PredictionQuestion, quiz: $quiz)
                    case is PlacingQuestion:
                        PlacingQuestionView(question: quiz.questions[quiz.currentQuestion] as! PlacingQuestion, quiz: $quiz)
                    case is MassEstimationQuestion:
                        MassEstimationQuestionView(question: quiz.questions[quiz.currentQuestion] as! MassEstimationQuestion, quiz: $quiz)
                    default:
                        Text("Bruh, error!")
                    }
                }
                HStack {
                    Text("Nivel: \(quiz.level)")
                    Text("Pregunta \(quiz.currentQuestion + 1) de \(quiz.questions.count)")
                    Text("Puntos: \(quiz.points)")
                    Button("Pregunta anterior") {
                        quiz.previousQuestion()
                    }
                    Button("Siguiente pregunta") {
                        quiz.nextQuestion()
                    }
                    Button("Regresar") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
            }
            .onAppear(perform: {
                quiz = Quiz(level: level) // To use actual level selected in QuizMenuView
        })
        }
        
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            QuizView(level: .constant(1))
        }
    }
}
