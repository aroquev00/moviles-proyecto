//
//  PredictionQuestionView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI

struct PredictionQuestionView: View {
    @State var question: PredictionQuestion
    @Binding var quiz: Quiz
    
    var body: some View {
        
        
        GeometryReader { geo in
            HStack(spacing: 0.0) {
                VStack {
                    Text("¿Qué pasará?")
                    SimulatorView(simulator: $question.simulator)
                    
                    // Answer options
                    HStack {
                        getPredictionButton3(text: "Se inclina a la izquierda", swivel: .left)
                        getPredictionButton(text: "Se queda nivelado", swivel: .equilibrium)
                        getPredictionButton(text: "Se inclina a la derecha", swivel: .right)
                        Button("Revisar") { question.checkAnswer() }
                    }
                }
                .frame(width: geo.size.width * 0.8)
                
                // MARK: - Side menu
                QuizPredSideMenuView(question: $question.asQuizQuestion, quiz: $quiz, resetQuestion: {
                    question = quiz.questions[quiz.currentQuestion] as! PredictionQuestion
                })
                    .frame(width: geo.size.width * 0.19)
                
            }
            
        }
    }
    
    func getPredictionButton(text: String, swivel: Swivel) -> some View {
        return Button(text) {
            question.selectedAnswer = swivel
            question.checkAnswer()
            addPoints()
        }
    }
    
    func getPredictionButton3(text: String, swivel: Swivel) -> some View {
            return Button(action: {
                question.selectedAnswer = swivel
                question.checkAnswer()
                addPoints()
            }, label: {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.largeTitle)
                    Text("Reiniciar")
                }
            })
        }
    
    func addPoints() {
        if question.answerStatus == .correct {
            quiz.points += 1
        }
    }
}

struct PredictionQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            PredictionQuestionView(question: PredictionQuestion(level: 1), quiz: .constant(Quiz(level: 1)))
        }
    }
}
