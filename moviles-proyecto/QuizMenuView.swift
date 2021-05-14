//
//  QuizMenuView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI

struct QuizMenuView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showQuiz: Bool = false
    @State var selectedLevelNumber = 0 // Placeholder value at start
    
    var body: some View {
        GeometryReader { mainGeo in
            ZStack {
                Color.white
                    //.resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("¡Elige un nivel!")
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        .fontWeight(.bold)
                        .font(.system(size: mainGeo.size.width * 0.07))
                    
                    HStack (spacing: 50) {
                        ForEach(1..<5) { i in
                            getLevelButton(level: i, for: mainGeo)
                        }
                    }
                    .frame(height: mainGeo.size.height * 0.3)
                    
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Menu")
                                .font(Font.custom("Bangers-Regular", size: (mainGeo.size.width * 0.05) + 10))
                                .tracking(5)
                                .frame(width: mainGeo.size.width * 0.28, height: mainGeo.size.height * 0.117, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color(#colorLiteral(red: 1, green: 0.6, blue: 0.07843137255, alpha: 1)))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .cornerRadius(20)
                        }
                    }
                    .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.2)
                }
            }
        }
    }
    
    // Function to return a View containing the button for the level
    func getLevelButton(level: Int, for geo: GeometryProxy) -> some View {
        return Button(action: {
            selectedLevelNumber = level
            showQuiz = true
        }) {
            Text("Nivel \(level)")
                .font(Font.custom("Bangers-Regular", size: (geo.size.width * 0.05) + 3))
                .tracking(5)
                .frame(width: geo.size.width * 0.19, height: geo.size.height * 0.21, alignment: .center)
                .background(Color(#colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.8, alpha: 1)))
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .cornerRadius(20)
                .fullScreenCover(isPresented: $showQuiz, content: {
                    QuizView(level: $selectedLevelNumber)
                })
            
        }
    }
}

struct QuizMenuView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            QuizMenuView()
        }
    }
}
