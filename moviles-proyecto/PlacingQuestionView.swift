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
            HStack {
                VStack {
                    Text("This is a placing question!")
                    Text("¡Coloca a \(question.simulator.selectedSprite!.name) en la posición adecuada para equilibrar la tabla!")
                    SimulatorView(simulator: $question.simulator)
                }
                .frame(width: geo.size.width * 0.8)
                
                VStack {
                    Image(uiImage: UIImage(named: question.simulator.selectedSprite!.imageURL)!)
                        .resizable()
                        .scaledToFit()
                    Text(String(question.simulator.selectedSprite!.weight) + " kg")
                }
                .frame(width: geo.size.width * 0.2)
            }
            
            
        }
        
    }
}

struct PlacingQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            PlacingQuestionView(question: PlacingQuestion(level: 1), quiz: .constant(Quiz(level: 1)))
        }
    }
}
