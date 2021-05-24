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
            GeometryReader { mainGeo in
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
                    GeometryReader { geo in
                        HStack(spacing: 75) {
                            Text("Nivel: \(quiz.level)")
                                .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.03))
                                .tracking(1)
                                .frame(width: geo.size.width * 0.1, height: geo.size.height)
                                .background(Color.secundaryBackground)
                                .foregroundColor(.mainButtonTextForeground)
                            Text("Pregunta \(quiz.currentQuestion + 1) de \(quiz.questions.count)")
                                .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.02))
                                .tracking(1)
                                .frame(width: geo.size.width * 0.15, height: geo.size.height)
                                .background(Color.mainTitleBackground)
                                .foregroundColor(.mainButtonTextForeground)
                            Text("Puntos: \(quiz.points)")
                                .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.03))
                                .tracking(1)
                                .frame(width: geo.size.width * 0.15, height: geo.size.height)
                                .background(Color.pointsBackground)
                                .foregroundColor(.mainButtonTextForeground)
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Regresar")
                                    .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.03))
                                    .tracking(1)
                                    .frame(width: geo.size.width * 0.16, height: geo.size.height)
                                    .background(Color.mainButtonBackground)
                                    .foregroundColor(.mainButtonTextForeground)
                                    .cornerRadius(20)
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    }
                    .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.075, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
