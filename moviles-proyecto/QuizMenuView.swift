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
        VStack {
            Text("¡Elige un nivel!")
            HStack {
                ForEach(1..<5) { i in
                    getLevelButton(level: i)
                }
            }
            .fullScreenCover(isPresented: $showQuiz, content: {
                QuizView(level: $selectedLevelNumber)
            })
            Button("Dismiss Me") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    // Function to return a View containing the button for the level
    func getLevelButton(level: Int) -> some View {
        return Button(action: {
            selectedLevelNumber = level
            showQuiz = true
        }) {
            Text("Nivel \(level)")
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
