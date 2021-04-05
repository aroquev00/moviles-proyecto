//
//  SimulatorView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 26/03/21.
//

import SwiftUI

struct SimulatorView: View {
    
    @State var rotation: Double = 0.0
    @State private var showingAlert = false
    @State var selectedNumber = 0.0
    
    // Data structure to store placed characters
    @Binding var simulator: Simulator
            
    var body: some View {
        VStack {
            GeometryReader { mainGeo in
                HStack(spacing: 0.0) {
                    Text("Nivel izquierdo")
                        .frame(width: mainGeo.size.width * 0.05)
                    ZStack {
                        Image("line")
                            .resizable()
                            .scaledToFit()
                        
                        
                                
                        HStack { // Sprites
                            ForEach(simulator.spots, id: \.self) { spot in
                                if let sprite = spot.sprite {
                                    Image(uiImage: sprite.image!)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: mainGeo.size.height / 3, alignment: .center)
                                        .offset(y: -45)
                                        .padding(-20)
                                } else {
                                    Text(".")
                                        
                                }
                                Spacer()
                            }
                            
                        }
                            .frame(width: mainGeo.size.width * 0.75)
                            
                        HStack() { // Buttons
                            ForEach(simulator.spots, id: \.self) { spot in
                                Button {
                                    simulator.spots[spot.index].sprite = Sprite(name: "Mario", weight: 20, height: 1, image: UIImage(named: "mario"))
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
