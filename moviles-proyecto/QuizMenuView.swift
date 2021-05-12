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
    @State var showMenu: Bool = false
    @State var selectedLevelNumber = 0 // Placeholder value at start
    
    var body: some View {
        ZStack {
            GeometryReader { mainGeo in
                VStack {
                    GeometryReader { geo in
                        HStack {
                            Text("¡Elige un nivel!")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .font(.system(size: 70))
                                .fixedSize()
                        }
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        
                    }
                    GeometryReader { geo in
                        HStack (spacing: 50) {
                            ForEach(1..<5) { i in
                                getLevelButton(level: i, for: geo)
                            }
                            
                        }
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    }
                    GeometryReader { geo in
                        HStack {
                            Button(action: {
                                showMenu = true
                            }) {
                                Text("Menu")
                                    .font(Font.custom("Bangers-Regular", size: 50))
                                    .tracking(5)
                                    .frame(width: 185, height: 65, alignment: .center)
                                    .background(Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 153/255, blue: 20/255, opacity: 1.0))
                                    .foregroundColor(.white)
                                    .fullScreenCover(isPresented: $showMenu, content: {
                                        MainMenuView()
                                    })
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    }
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
                .font(Font.custom("Bangers-Regular", size: 50))
                .tracking(5)
                .frame(width: geo.size.width * 0.2, height: 65, alignment: .center)
                .background(Color.init(Color.RGBColorSpace.sRGB, red: 59/255, green: 40/255, blue: 204/255, opacity: 1.0))
                .foregroundColor(.white)
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
