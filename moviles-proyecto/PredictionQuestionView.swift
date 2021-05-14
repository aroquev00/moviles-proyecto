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
