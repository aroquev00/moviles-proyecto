//
//  QuizAlertView.swift
//  moviles-proyecto
//
//  Created by Guillermo García on 14/05/21.
//

import SwiftUI

struct QuizAlertView: View {
    
    @Binding var alertVisible: Bool
    @Binding var activeAlert: ActiveAlert
    @Binding var quiz: Quiz
    @Binding var question: QuizQuestion
    
    @State var showCalculations: Bool = false
    
    var body: some View {
        GeometryReader { mainGeo in
            ZStack {
                //Structure: Text - Text - Hstack{Buttons}
                VStack {
                    //Message depends on activeAlert value
                    getTitleText(geo: mainGeo)
                    Spacer()
                    getSubtitleText(geo: mainGeo)
                        .multilineTextAlignment(.center)
                    Spacer()
                    //Buttons
                   // GeometryReader { geo in
                    HStack(spacing: mainGeo.size.width * 0.05) {
                            //TryAgain
                            if activeAlert == .first {
                                Button(action: {
                                    alertVisible.toggle()
                                }) {
                                    getButtonText(text: "Intentar de nuevo", geo: mainGeo)
                                }
                            }
                            
                            //Next question
                            if activeAlert == .first || activeAlert == .second {
                                Button(action: {
                                    quiz.nextQuestion()
                                }) {
                                    getButtonText(text: "Siguiente pregunta", geo: mainGeo)
                                }
                            }
                            
                            //CalculationsView
                            if activeAlert == .third {
                                Button {
                                    // Show calc screen
                                    showCalculations = true
                                    
                                } label: {
                                    getButtonText(text: "Ver cálculos", geo: mainGeo)
                                }
                                .fullScreenCover(isPresented: $showCalculations, content: {
                                    CalculationsView(simulator: $question.simulator)
                                })
                            }
                        }
                    Spacer()
                        //.frame(width: mainGeo.size.width, height: geo.size.height/3, alignment: .center)
                  //  }
                }
                .padding(.bottom, mainGeo.size.height * 0.05)
                .padding(.horizontal, mainGeo.size.width * 0.05)
//                    .cornerRadius(25)
                    
                //Dismiss button
    //            Button(action: {
    //                alertVisible.toggle()
    //            }) {
    //                Image(systemName: "xmark.circle")
    //                    .font(.system(size: 40, weight: .bold))
    //                    .foregroundColor(.mainTextForeground)
    //            }
            }
            .frame(width: mainGeo.size.width, height: mainGeo.size.height)
            .background(activeAlert == .second ? Color.correctAlertBackground : Color.wrongAlertBackground)
        }
        
    }
    
    func getTitleText(geo: GeometryProxy) -> some View {
        var returnText: Text
        switch activeAlert {
        case .first, .third:
            returnText = Text("Incorrecto")
        case .second:
            returnText = Text("¡Correcto!")
        }
        return returnText
            .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.06))
            .tracking(5)
            .frame(width: geo.size.width)
            .background(Color.mainButtonBackground)
            .foregroundColor(.mainTextForeground)
    }
    
    func getSubtitleText(geo: GeometryProxy) -> some View {
        var returnText: Text
        switch activeAlert {
        case .first:
            returnText = Text("Avanza a la siguiente pregunta o intentalo de nuevo.\("\n")¡Tú puedes!")
        case .second:
            returnText = Text("Avanza a la siguiente pregunta")
            
        case .third:
            returnText = Text("Avanza para ver los cálculos de esta pregunta")
        }
        return returnText
            .font(.system(size: geo.size.width * 0.03))
            .foregroundColor(.mainTextForeground)
    }
    
    func getButtonText(text: String, geo: GeometryProxy) -> some View {
        Text(text)
            .font(.system(size: geo.size.width * 0.035))
            .padding()
            .frame(width: geo.size.width * 0.4)
            .background(Color.alertButtonBackground)
            .foregroundColor(.mainTextForeground)
            .clipShape(Capsule())
    }
}

struct QuizAlertView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            QuizAlertView(alertVisible: .constant(false), activeAlert: .constant(.first), quiz: .constant(Quiz(level: 1)), question: .constant(PredictionQuestion(level: 1)))
        }
    }
}
