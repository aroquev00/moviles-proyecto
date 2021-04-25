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
    
    var body: some View {
        VStack {
            Text("¡Elige un nivel!")
            Button(action: {
                showQuiz = true
            }) {
                Text("Nivel 1")
            }
            .fullScreenCover(isPresented: $showQuiz, content: {
                QuizView(quiz: Quiz(level: 1))
            })
            Button("Dismiss Me") {
                presentationMode.wrappedValue.dismiss()
            }
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
