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

                HStack(spacing: 0.0) {

                    VStack {
                        Text("¿Qué pasará?")
                        SimulatorView(simulator: $question.simulator)
                    }
                    .frame(width: geo.size.width * 0.8)
                
                    // MARK: - Side menu
                    VStack {
                        let switchesVerticalPadding: CGFloat = geo.size.height * 0.03
                        // MARK: Ruler switch
                        HStack {
                            Spacer()
                            Toggle("",isOn: $question.simulator.rulerEnabled)
                                .labelsHidden()
                            Spacer()
                            Image(systemName: "ruler.fill")
                                .foregroundColor(Color.orange)
                                .font(.largeTitle)
                            Spacer()
                        }
                        .frame(width: geo.size.width * 0.19)
                        .padding(EdgeInsets(top: switchesVerticalPadding, leading: 0, bottom: switchesVerticalPadding, trailing: 0))
                        .background(Color.init(Color.RGBColorSpace.sRGB, red: 59/255, green: 40/255, blue: 204/255, opacity: 1.0))
                    
                        VStack {
                            getPredictionButton(text: "Se inclina a la izquierda", swivel: .left, image: Image("izquierda"), size: geo.size.width * 0.19)
                            getPredictionButton(text: "Se queda nivelado", swivel: .equilibrium , image: Image("equilibrium"), size: geo.size.width * 0.19)
                            getPredictionButton(text: "Se inclina a la derecha", swivel: .right, image: Image("derecha"), size: geo.size.width * 0.19)
                        }
                    
                    }.frame(width: geo.size.width * 0.19)
                
                }
                
                //Triggers QuizAlertView when answer is checked
                if alertVisible {
                    QuizAlertView(alertVisible: $alertVisible, activeAlert: $activeAlert, quiz: $quiz, predQuestion: $question, massEstQuestion: $dummyMassEstQuestion, placingQuestion: $dummyPlacingQuestion, quizType: $quizType)
                        .frame(width: geo.size.width/2, height: geo.size.height / 4, alignment: .center)
                }
            }
        }
        
    }
    
    func getPredictionButton(text: String, swivel: Swivel, image: Image, size: CGFloat) -> some View {
            return Button(action: {
                question.selectedAnswer = swivel
                question.checkAnswer()
                addPoints()
            }, label: {
                HStack {
                    image.resizable()
                        .scaledToFit().frame(width: size)
                }
            })
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
