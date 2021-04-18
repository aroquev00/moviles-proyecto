//
//  SimulatorView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 26/03/21.
//

import SwiftUI

struct SimulatorView: View {
    
    @Binding var simulator: Simulator // Data structure to store placed characters
            
    var body: some View {
        VStack {
            GeometryReader { mainGeo in
                HStack(spacing: 0.0) {
                    Text("Nivel izquierdo")
                        .frame(width: mainGeo.size.width * 0.05)
                    ZStack {
                        Image("tabla")
                            .resizable()
                            .scaledToFit()
                        
                        
                        let barWidth = mainGeo.size.width * 0.75
                        ZStack { // Sprites
                            
                            ForEach(simulator.spots, id: \.self) { spot in
                                if let sprite = spot.sprite {
                                    Image(uiImage: sprite.image!)
                                        .resizable()
                                        .scaledToFit()
                                        //.frame(width: barWidth/16, height: mainGeo.size.height / 3, alignment: .center)
                                        .frame(height: mainGeo.size.height / 3, alignment: .center)
                                        .position(x: barWidth / 16 * CGFloat(spot.index + 1), y: mainGeo.size.height/2 - 45) // Needs work
                                        
                                        //.offset(y: -45)
                                        //.padding(-15)
                                        //.position(x: 50)
                                        //.padding(EdgeInsets(top: 0, leading: -barWidth/16 - 1, bottom: 0, trailing: -barWidth/16 - 1))
                                }
                            }
                            
                        }
                            
                        HStack() { // Buttons
                            ForEach(simulator.spots, id: \.self) { spot in
                                Button {
                                    simulator.spots[spot.index].sprite = simulator.selectedSprite
                                } label: {
                                    Text(simulator.rulerEnabled ?  String(spot.distance) : "|"
                                        )
                                        .font(.system(size: 15))
                                }
                                Spacer()
                            }
                        }
                            .frame(width: mainGeo.size.width * 0.75)
                        
                    }
                        .frame(width: mainGeo.size.width * 0.9)
                        .rotationEffect(
                            simulator.totalTorque > 20 ? .degrees(Double(20)) : (simulator.totalTorque < -20 ? .degrees(Double(-20))  : .degrees(Double(simulator.totalTorque)))
                        )
                        .animation(.easeIn)
                    
                    
                    Text("Nivel derecho")
                        .frame(width: mainGeo.size.width * 0.05)
                }
                .frame(width: mainGeo.size.width, height: mainGeo.size.height)
                
            }
            
            Text(String(simulator.totalTorque))
            
        }
        
    }
}

struct SimulatorView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            SimulatorView(simulator: .constant(Simulator()))
        }
        
    }
}
