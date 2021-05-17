//
//  PlacingQuestionView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI


struct PlacingQuestionView: View {
    @State var question: PlacingQuestion
    @Binding var quiz: Quiz
    @State var incorrectNum = 0
    @State var alertVisible: Bool = false
    @State var activeAlert: ActiveAlert = .first
    
    //Dummy questions sent to QuizAlertView
    @State var dummyPredQuestion: PredictionQuestion = PredictionQuestion(level: 1)
    @State var dummyMassEstQuestion: MassEstimationQuestion = MassEstimationQuestion(level: 1)
    //Helps QuizAlertView know quiz type and show calculations
    @State var quizType: Int = 3
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack(spacing: 0.0) {
                    VStack {
                        Text("¡Coloca a \(question.simulator.selectedSprite!.name) en la posición adecuada para equilibrar la tabla!")
                        SimulatorView(simulator: $question.simulator)
                    }
                    .frame(width: geo.size.width * 0.8)
                    
                    // MARK: - Side menu
                    QuizSideMenuView(question: $question.asQuizQuestion, quiz: $quiz, resetQuestion: {
                        question = quiz.questions[quiz.currentQuestion] as! PlacingQuestion
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

struct PlacingQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            PlacingQuestionView(question: PlacingQuestion(level: 1), quiz: .constant(Quiz(level: 1)))
        }
    }
}
