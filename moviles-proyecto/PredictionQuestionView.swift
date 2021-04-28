//
//  PredictionQuestionView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI

enum ActiveAlert{
    case first, second
}

struct PredictionQuestionView: View {
    @State var question: PredictionQuestion
    @State var alertVisible: Bool = false
    @State var activeAlert: ActiveAlert = .first
    @Binding var quiz: Quiz
    
    var body: some View {
        
        
        GeometryReader { geo in
            VStack {
                Text("This is a prediction question!")
                Text("¿Qué pasará?")
                SimulatorView(simulator: $question.simulator)
                
                // Answer options
                HStack {
                    getPredictionButton(text: "Se inclina a la izquierda", swivel: .left)
                    getPredictionButton(text: "Se queda nivelado", swivel: .equilibrium)
                    getPredictionButton(text: "Se inclina a la derecha", swivel: .right)
                }.alert(isPresented: $alertVisible, content: {
                    switch activeAlert{
                    case .first:
                        return Alert(title: Text( "Incorrecto"), message: Text("Avanza a la siguiente pregunta o intentalo de nuevo, Tu puedes!"), primaryButton: .default(Text("Retry")), secondaryButton: .default(Text("Next"), action: { quiz.nextQuestion()} ))
                    case .second:
                        return Alert(title: Text("Correcto!"), message: Text("Avanza a la siguiente pregunta"), dismissButton: .default(Text("Next"), action: { quiz.nextQuestion()} ))
                    }})
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
    
    func getAlert(){
        
    }
    
    func getPredictionButton(text: String, swivel: Swivel) -> some View {
        return Button(text) {
            question.selectedAnswer = swivel
            question.checkAnswer()
            addPoints()
        }
    }
    
    func addPoints() {
        if question.answerStatus == .correct {
            quiz.points += 1
            alertVisible = true
            activeAlert = .second
        }
        else if question.answerStatus == .incorrect {
            alertVisible = true
            activeAlert = .first
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
