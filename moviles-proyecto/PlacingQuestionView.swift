//
//  PlacingQuestionView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI

struct PlacingQuestionView: View {
    @State var question: PlacingQuestion
    @Binding var quiz: Quiz
    
    var body: some View {
        GeometryReader { geo in
            
            
        }
        Text("This is a placing question!")
    }
}

struct PlacingQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        PlacingQuestionView(question: PlacingQuestion(level: 1), quiz: .constant(Quiz(level: 1)))
    }
}
