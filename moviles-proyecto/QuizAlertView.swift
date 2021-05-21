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
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            //Structure: Text - Text - Hstack{Buttons}
            VStack() {
                //Message depends on activeAlert value
                getTitleText()
                Spacer()
                getSubtitleText()
                Spacer()
                //Buttons
                GeometryReader { geo in
                    HStack {
                        //TryAgain
                        if activeAlert == .first {
                            Button(action: {
                                alertVisible.toggle()
                            }) {
                                Text("Intentar de nuevo")
                                    .font(.system(size: 30))
                                    //.tracking(5)
                                    .frame(height: 65, alignment: .center)
                                    .background(Color.alertButtonBackground)
                                    .clipShape(Capsule())
                                    .foregroundColor(.mainTextForeground)
                            }
                        }
                        
                        //Next question
                        if activeAlert == .first || activeAlert == .second {
                            Button(action: {
                                quiz.nextQuestion()
                            }) {
                                Text("Siguiente pregunta")
                                    .font(.system(size: 30))
                                    //.tracking(5)
                                    .frame(height: 65, alignment: .center)
                                    .background(Color.alertButtonBackground)
                                    .clipShape(Capsule())
                                    .foregroundColor(.mainTextForeground)
                            }
                        }
                        
                        //CalculationsView
                        if activeAlert == .third {
                            Button {
                                // Show calc screen
                                showCalculations = true
                                
                            } label: {
                                Text("Ver cálculos")
                                    .font(.system(size: 30))
                                    //.tracking(5)
                                    .frame(height: 65, alignment: .center)
                                    .background(Color.alertButtonBackground)
                                    .foregroundColor(.mainTextForeground)
                                    .clipShape(Capsule())
                                    .foregroundColor(.mainTextForeground)
                            }
                            .fullScreenCover(isPresented: $showCalculations, content: {
                                
                                CalculationsView(simulator: $question.simulator)
                            })
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height/3, alignment: .center)
                    .padding()
                }
            }
                .padding(.vertical, 25)
                .padding(.horizontal, 30)
                .cornerRadius(25)
                
            //Dismiss button
            Button(action: {
                alertVisible.toggle()
            }) {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.mainTextForeground)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(activeAlert == .second ? Color.correctAlertBackground : Color.wrongAlertBackground)
    }
    
    func getTitleText() -> some View {
        switch activeAlert {
        case .first, .third:
        return
            Text("Incorrecto")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.mainTextForeground)
        
        case .second:
            return
                Text("¡Correcto!")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.mainTextForeground)
        }
    }
    
    func getSubtitleText() -> some View {
        switch activeAlert {
        case .first:
        return
            Text("Avanza a la siguiente pregunta o intentalo de nuevo. ¡Tu puedes!")
                .font(.system(size: 30))
                .foregroundColor(.mainTextForeground)
        
        case .second:
            return
                Text("Avanza a la siguiente pregunta")
                    .font(.system(size: 30))
                    .foregroundColor(.mainTextForeground)
            
        case .third:
            return
                Text("Avanza para ver los cálculos de esta pregunta")
                    .font(.system(size: 30))
                    .foregroundColor(.mainTextForeground)
        }
    }
}

struct QuizAlertView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            QuizAlertView(alertVisible: .constant(false), activeAlert: .constant(.first), quiz: .constant(Quiz(level: 1)), question: .constant(PredictionQuestion(level: 1)))
        }
    }
}
