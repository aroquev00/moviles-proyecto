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
    
    //Array with the 3 possible message outputs
    let messages = ["Calcula la torca resultante según los personajes que están en la tabla y presiona el botón que represente cómo quedaría si se quitan los soportes.",
                    "Primero, balancea la tabla colocando al personaje que se te da en el lugar que le corresponda.\nDespúes, realiza los cálculos necesarios para despejar la masa del personaje especificado.\nReporta el resultado utilizando el slider que se encuentra debajo de la tabla.",
                    "Haz los cálculos necesarios para saber en qué posición debe ir el personaje indicado para que la tabla esté balanceada si se quitan los soportes. Es decir, que la torca resultante sea 0."]
    
    var body: some View {
        GeometryReader { mainGeo in
            ZStack {
                //Background color
                Color.quizHelpBackground
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        GeometryReader { geo in
                            //Bar at the top
                            HStack() {
                                Spacer()
                                //Back button
                                Button {
                                    // Dismiss view
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Image(systemName: "arrowshape.turn.up.left.fill")
                                        .resizable()
                                        .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.4)
                                        .foregroundColor(Color.mainButtonBackground)
                                }
                                //Title text
                                Text("Ayuda")
                                    .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.06))
                                    .tracking(5)
                                    .frame(width: geo.size.width, height: geo.size.height)
                                    .foregroundColor(.mainTitleTextForeground)
                            }
                            .background(Color.mainTitleBackground)
                        }
                        .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.2)
                        
                        Spacer()
                        
                        //Help text
                        HStack {
                            if question.questionType == .prediction {
                                Text(messages[0])
                                    .font(.system(size: mainGeo.size.width * 0.05))
                                    .foregroundColor(Color.mainTextForeground)
                            }
                            else if question.questionType == .massEstimation {
                                Text(messages[1])
                                    .font(.system(size: mainGeo.size.width * 0.05))
                                    .foregroundColor(Color.mainTextForeground)
                            }
                            else {
                                Text(messages[2])
                                    .font(.system(size: mainGeo.size.width * 0.05))
                                    .foregroundColor(Color.mainTextForeground)
                            }
                        }
                        .frame(width: mainGeo.size.width * 0.95, alignment: .topLeading)
                    }
                }
            }
        }
    }
}

struct QuizHelpView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            QuizHelpView(question: .constant(PredictionQuestion(level: 1)))
        }
    }
}
