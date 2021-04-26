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
            VStack {
                Text("This is a prediction question!")
                Text("¿Qué pasará?")
                SimulatorView(simulator: $question.simulator)
                
                // Answer options
                HStack {
                    Button("Se inclina a la izquierda") {
                        question.selectedAnswer = Swivel.left
                        question.checkAnswer()
                        addPoints()
                    }
                    Button("Se queda nivelado") {
                        question.selectedAnswer = Swivel.equilibrium
                        question.checkAnswer()
                        addPoints()
                    }
                    Button("Se inclina a la derecha") {
                        question.selectedAnswer = Swivel.right
                        question.checkAnswer()
                        addPoints()
                    }
                }
                switch question.answerStatus {
                case AnswerStatus.correct:
                    Text("Answer status: Correct")
                case AnswerStatus.incorrect:
                    Text("Answer status: Incorrect")
                case AnswerStatus.unanswered:
                    Text("Answer status: Unanswered")
                }
                
            }
        }
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
