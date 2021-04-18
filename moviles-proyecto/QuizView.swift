//
//  QuizView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var quiz: Quiz
    
    var body: some View {
        VStack {
            Text("This is a quiz")
            switch quiz.questions[quiz.currentQuestion] {
            case is PredictionQuestion:
                PredictionQuestionView()
            case is PlacingQuestion:
                PlacingQuestionView()
            case is MassEstimationQuestion:
                MassEstimationQuestionView()
            default:
                Text("Bruh, error!")
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
        
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            QuizView(quiz: Quiz(level: 1))
        }
    }
}
