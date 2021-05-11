//
//  QuizPredSideMenuView.swift
//  moviles-proyecto
//
//  Created by user189615 on 5/11/21.
//

import SwiftUI

struct QuizPredSideMenuView: View {
    @Binding var question: QuizQuestion
    @Binding var quiz: Quiz
    
    let resetQuestion: () -> Void
    
    var body: some View {
        GeometryReader { sideGeo in
            let switchesVerticalPadding: CGFloat = sideGeo.size.height * 0.03
            VStack {
                Button(action: resetQuestion, label: {
                    HStack {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.largeTitle)
                        Text("Reiniciar")
                            .font(Font.custom("Bangers-Regular", size: sideGeo.size.width * 0.15))
                            .tracking(2)
                    }
                    .frame(width: sideGeo.size.width)
                    .padding(EdgeInsets(top: switchesVerticalPadding, leading: 0, bottom: switchesVerticalPadding, trailing: 0))
                    .background(Color.init(Color.RGBColorSpace.sRGB, red: 59/255, green: 40/255, blue: 204/255, opacity: 1.0))
                    .foregroundColor(.red)
                    
                })
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
                        .frame(width: sideGeo.size.width)
                        .padding(EdgeInsets(top: switchesVerticalPadding, leading: 0, bottom: switchesVerticalPadding, trailing: 0))
                        .background(Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 153/255, blue: 20/255, opacity: 1.0))
                        .foregroundColor(.white)
                }
                
                Spacer()
                /*
                VStack {
                    Image(uiImage: UIImage(named: question.simulator.selectedSprite!.imageURL)!)
                    .resizable()
                     .scaledToFit()
                    //Text(String(format: "%.2f", question.simulator.selectedSprite!.weight) + " kg")
                    Text(String(format: (floor(question.simulator.selectedSprite!.weight) == question.simulator.selectedSprite!.weight ? "%.0f" : "%.2f"), question.simulator.selectedSprite!.weight) + " kg")
                        .font(Font.custom("Bangers-Regular", size: sideGeo.size.width * 0.2))
                        .foregroundColor(.orange)
                 
                }
                 */
            }
        }
    }
}


struct QuizPredSideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            QuizSideMenuView(question: .constant(PlacingQuestion(level: 1)), quiz: .constant(Quiz(level: 1)), resetQuestion: {})
        }
    }
}
