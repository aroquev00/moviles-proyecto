//
//  QuizHelpView.swift
//  moviles-proyecto
//
//  Created by Guillermo García on 25/05/21.
//

import SwiftUI

struct QuizHelpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var question: QuizQuestion
    
    // Array with the 3 possible message outputs
    let messages = ["Calcula la torca resultante según los personajes que están en la tabla y presiona el botón que represente cómo quedaría si se quitan los soportes.",
                    "Primero, balancea la tabla colocando al personaje que se te da en el lugar que le corresponda.\nDespúes, realiza los cálculos necesarios para despejar la masa del personaje especificado.\nReporta el resultado utilizando el slider que se encuentra debajo de la tabla.",
                    "Haz los cálculos necesarios para saber en qué posición debe ir el personaje indicado para que la tabla esté balanceada si se quitan los soportes.\nEs decir, que la torca resultante sea 0."
    ]
    
    var body: some View {
        GeometryReader { mainGeo in
            ZStack {
                // Background color
                Color.quizHelpBackground
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        // Bar at the top
                        HStack {
                            Spacer()
                                .frame(width: mainGeo.size.width * 0.02)
                            //Back button
                            Button {
                                // Dismiss view
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "arrowshape.turn.up.left.fill")
                                    .resizable()
                                    .frame(width: mainGeo.size.width * 0.05, height: mainGeo.size.height * 0.08)
                                    .foregroundColor(Color.mainButtonBackground)
                            }
                            Spacer()
                            // Title text
                            Text("Ayuda")
                                .font(Font.custom("Bangers-Regular", size: mainGeo.size.width * 0.06))
                                .tracking(5)
                                .frame(width: mainGeo.size.width * 0.5, height: mainGeo.size.height *  0.2)
                                .foregroundColor(.mainTitleTextForeground)
                            Spacer()
                        }
                        .frame(width: mainGeo.size.width)
                        .background(Color.mainTitleBackground)
                        
                        getHelpMessage(questionType: question.questionType, geo: mainGeo)
                            .frame(width: mainGeo.size.width * 0.95, height: mainGeo.size.height, alignment: .topLeading)
                    }
                }
                .frame(width: mainGeo.size.width)
            }
            
        }
    }
    
    func getHelpMessage(questionType: QuizQuestionType, geo: GeometryProxy) -> some View {
        var returnText: Text
        if questionType == .prediction {
            returnText = Text(messages[0])
        }
        else if questionType == .massEstimation {
            returnText = Text(messages[1])
        }
        else {
            returnText = Text(messages[2])
        }
        return returnText
            .font(.system(size: geo.size.width * 0.05))
            .foregroundColor(Color.mainTextForeground)
    }
}

struct QuizHelpView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            QuizHelpView(question: .constant(PredictionQuestion(level: 1)))
        }
    }
}
