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
    @Binding var quizType: Int //1 is for prediction, 2 is for mass estimation, and 3 is for placing
    
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
                                    .background(Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 255/255, blue: 255/255, opacity: 1.0))
                                    .foregroundColor(.black)
                                    .clipShape(Capsule())
                                    .foregroundColor(.black)
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
                                    .background(Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 255/255, blue: 255/255, opacity: 1.0))
                                    .foregroundColor(.black)
                                    .clipShape(Capsule())
                                    .foregroundColor(.black)
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
                                    .background(Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 255/255, blue: 255/255, opacity: 1.0))
                                    .foregroundColor(.black)
                                    .clipShape(Capsule())
                                    .foregroundColor(.black)
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
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(activeAlert == .second ? Color.init(Color.RGBColorSpace.sRGB, red: 50/255, green: 168/255, blue: 82/255, opacity: 1.0) : Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 111/255, blue: 111/255, opacity: 1.0))
    }
    
    func getTitleText() -> some View {
        switch activeAlert {
        case .first, .third:
        return
            Text("Incorrecto")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.black)
        
        case .second:
            return
                Text("¡Correcto!")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.black)
        }
    }
    
    func getSubtitleText() -> some View {
        switch activeAlert {
        case .first:
        return
            Text("Avanza a la siguiente pregunta o intentalo de nuevo. ¡Tu puedes!")
                .font(.system(size: 30))
                .foregroundColor(.black)
        
        case .second:
            return
                Text("Avanza a la siguiente pregunta")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
            
        case .third:
            return
                Text("Avanza para ver los cálculos de esta pregunta")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
        }
    }
}

struct QuizAlertView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            QuizAlertView(alertVisible: .constant(false), activeAlert: .constant(.first), quiz: .constant(Quiz(level: 1)), question: .constant(PredictionQuestion(level: 1)), quizType: .constant(1))
        }
    }
}
