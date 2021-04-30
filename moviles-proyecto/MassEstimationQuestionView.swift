//
//  MassEstimationQuestionView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI

struct MassEstimationQuestionView: View {
    @State var question: MassEstimationQuestion
    @Binding var quiz: Quiz
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("This is a mass estimation question!")
                Text("¿Cuál es la masa del objeto?")
                SimulatorView(simulator: $question.simulator)
                // Text field or slider to input weight
            }
        }
    }
}

struct MassEstimationQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            MassEstimationQuestionView(question: MassEstimationQuestion(level: 1), quiz: .constant(Quiz(level: 1)))
        }
    }
}
