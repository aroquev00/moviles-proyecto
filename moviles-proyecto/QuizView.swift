//
//  QuizView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var quiz: Quiz
    
    var body: some View {
        VStack {
            Text("This is a quiz")
            
            HStack {
                Text("Nivel: \(quiz.level)")
                Text("Pregunta 1 de 6")
                Text("Puntos: \(quiz.points)")
                Button("Regresar") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
        }
        
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            QuizView(quiz: Quiz(level: 1, points: 0, questions: [QuizQuestion]()))
        }
    }
}
