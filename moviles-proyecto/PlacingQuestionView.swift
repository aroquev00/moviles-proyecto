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
            HStack(spacing: 0.0) {
                VStack {
                    Text("This is a placing question!")
                    Text("¡Coloca a \(question.simulator.selectedSprite!.name) en la posición adecuada para equilibrar la tabla!")
                    SimulatorView(simulator: $question.simulator)
                }
                .frame(width: geo.size.width * 0.8)
                
                // MARK: - Side menu
                GeometryReader { sideGeo in
                    let switchesVerticalPadding: CGFloat = sideGeo.size.height * 0.03
                    VStack {
                        Text("Reset question")
                        // MARK: Ruler switch
                        HStack {
                            Spacer()
                            Toggle("",isOn: $question.simulator.rulerEnabled)
                                .labelsHidden()
                            Spacer()
                            Image(systemName: "ruler.fill")
                                .foregroundColor(Color.orange)
                                .font(.largeTitle)
                            Spacer()
                        }
                        .frame(width: sideGeo.size.width)
                        .padding(EdgeInsets(top: switchesVerticalPadding, leading: 0, bottom: switchesVerticalPadding, trailing: 0))
                        .background(Color.init(Color.RGBColorSpace.sRGB, red: 59/255, green: 40/255, blue: 204/255, opacity: 1.0))
                        
                        // MARK: Check button
                        Button(action: {
                            question.checkAnswer()
                        }) {
                            Text("Revisar")
                                .font(Font.custom("Bangers-Regular", size: sideGeo.size.width * 0.25))
                                .tracking(2)
                                //.padding()
                                .frame(width: sideGeo.size.width)
                                .background(Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 153/255, blue: 20/255, opacity: 1.0))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        VStack {
                            Image(uiImage: UIImage(named: question.simulator.selectedSprite!.imageURL)!)
                                .resizable()
                                .scaledToFit()
                            Text(String(question.simulator.selectedSprite!.weight) + " kg")
                        }
                        
                    }
                }
                .frame(width: geo.size.width * 0.19)
                
                
                
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
