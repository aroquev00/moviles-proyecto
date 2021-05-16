//
//  PredictionQuestionView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI

enum ActiveAlert{
    case first, second, third
}

struct PredictionQuestionView: View {
    @State var question: PredictionQuestion
    @State var alertVisible: Bool = false
    @State var activeAlert: ActiveAlert = .first
    @Binding var quiz: Quiz
    @State var incorrectNum = 0
    
    //Dummy questions sent to QuizAlertView
    @State var dummyMassEstQuestion: MassEstimationQuestion = MassEstimationQuestion(level: 1)
    @State var dummyPlacingQuestion: PlacingQuestion = PlacingQuestion(level: 1)
    //Helps QuizAlertView know quiz type and show calculations
    @State var quizType: Int = 1
    
    var body: some View {
        
        
        GeometryReader { geo in
            ZStack {
                VStack {
                    Text("¿Qué pasará?")
                    SimulatorView(simulator: $question.simulator)
                    
                    // Answer options
                    HStack {
                        getPredictionButton(text: "Se inclina a la izquierda", swivel: .left)
                        getPredictionButton(text: "Se queda nivelado", swivel: .equilibrium)
                        getPredictionButton(text: "Se inclina a la derecha", swivel: .right)
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
                
                //Triggers QuizAlertView when answer is checked
                if alertVisible {
                    QuizAlertView(alertVisible: $alertVisible, activeAlert: $activeAlert, quiz: $quiz, predQuestion: $question, massEstQuestion: $dummyMassEstQuestion, placingQuestion: $dummyPlacingQuestion, quizType: $quizType)
                        .frame(width: geo.size.width/2, height: geo.size.height / 4, alignment: .center)
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
        print(incorrectNum)
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

struct PredictionQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            PredictionQuestionView(question: PredictionQuestion(level: 1), quiz: .constant(Quiz(level: 1)))
        }
    }
}
