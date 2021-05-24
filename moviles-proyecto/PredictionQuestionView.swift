//
//  PredictionQuestionView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI

struct PredictionQuestionView: View {
    @State var question: PredictionQuestion
    @State var alertVisible: Bool = false
    
    @State var activeAlert: ActiveAlert = .first
    @Binding var quiz: Quiz
    @State var incorrectNum = 0
    
    var body: some View {
        GeometryReader { geo in

            ZStack {
                HStack(spacing: 0.0) {

                    VStack {
                        Text("¿Qué pasará?")
                            .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.05))
                            .tracking(1)
                            .frame(width: geo.size.width * 0.3, height: geo.size.width * 0.1)
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .background(Color.mainTitleBackground)
                            .border(Color.mainTitleBackgroundBorder, width: 7)
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
                                .resizable()
                                .foregroundColor(.rulerFill)
                                .frame(width: geo.size.width * 0.06, height: geo.size.height * 0.06, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        .frame(width: geo.size.width * 0.19)
                        .padding(EdgeInsets(top: switchesVerticalPadding, leading: 0, bottom: switchesVerticalPadding, trailing: 0))
                        .background(Color.resetButtonBackground)
                        .cornerRadius(10)
                    
                        VStack {
                            getPredictionButton(text: "Se inclina a la izquierda", swivel: .left, image: Image("izquierda"), size: geo.size.width * 0.19)
                            getPredictionButton(text: "Se queda nivelado", swivel: .equilibrium , image: Image("equilibrium"), size: geo.size.width * 0.19)
                            getPredictionButton(text: "Se inclina a la derecha", swivel: .right, image: Image("derecha"), size: geo.size.width * 0.19)
                        }
                    
                    }
                    .frame(width: geo.size.width * 0.19)
                }
                .blur(radius: alertVisible ? 3.0 : 0.0)
                .disabled(alertVisible)
                
                //Triggers QuizAlertView when answer is checked
                if alertVisible {
                    QuizAlertView(alertVisible: $alertVisible, activeAlert: $activeAlert, quiz: $quiz, question: $question.asQuizQuestion)
                        .frame(width: geo.size.width * 0.75, height: geo.size.height * 0.75, alignment: .center)
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
                .cornerRadius(10)
            })
        }
    
    func addPoints() {
        print(incorrectNum)
        if question.answerStatus == .correct {
            switch incorrectNum {
            case 0:
                quiz.points += 3
            case 1:
                quiz.points += 2
            default:
                quiz.points += 1
            }
            activeAlert = .second
        }
        else if question.answerStatus == .incorrect {
            if incorrectNum != 3 { incorrectNum += 1 }
            if incorrectNum == 3 {
                activeAlert = .third
                question.solveQuestion()
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
