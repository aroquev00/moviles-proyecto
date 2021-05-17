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
                Color.whiteBackground
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("¡Elige un nivel!")
                        .foregroundColor(.mainTextForeground)
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
                                .frame(width: mainGeo.size.width * 0.28, height: mainGeo.size.height * 0.117)
                                .background(Color.mainButtonBackground)
                                .foregroundColor(.mainButtonTextForeground)
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
                .frame(width: geo.size.width * 0.19, height: geo.size.height * 0.21)
                .background(Color.selectLevelButtonBackground)
                .foregroundColor(.mainButtonTextForeground)
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
