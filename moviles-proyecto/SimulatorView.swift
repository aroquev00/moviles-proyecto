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
    @State var simulator: Simulator = Simulator.init()
    
    var body: some View {
        VStack {
            GeometryReader { mainGeo in
                HStack(spacing: 0.0) {
                    Text("Nivel izq")
                        .frame(width: mainGeo.size.width * 0.1)
                    ZStack {
                        Image("line")
                            .resizable()
                            .scaledToFit()
                                
                        HStack { // Buttons and characters stack
                            ForEach(simulator.spots, id: \.self) { spot in
                                GeometryReader { vGeo in
                                    VStack() {
                                        if let sprite = spot.sprite {
                                            Image(uiImage: sprite.image!)
                                                .resizable()
                                                .scaledToFit()
                                                //.padding(-20)
                                                .frame(height: vGeo.size.height * 0.4)
                                                //.position(x: 0)
                                        } else {
                                            Text("Placeholder")
                                                .frame(height: vGeo.size.height * 0.4)
                                        }
//                                        Image(uiImage: UIImage(named: "mario")!)
//                                            .resizable()
//                                            .scaledToFit()
//                                            .padding(-20)
                                        Button {
                                            simulator.spots[spot.index].sprite = Sprite(name: "Mario", weight: 20, height: 1, image: UIImage(named: "mario"))
                                        } label: {
                                            Text(String(spot.distance))
                                                .font(.system(size: 10))
                                        }
                                        .frame(height: vGeo.size.height * 0.5, alignment: .top)
                                        //.frame(height: 10, alignment: .top)
                                        //.position(y: vGeo.size.height / 2)
                                        
                                    }
                                        .position(y: vGeo.size.height / 2)
                                    
                                }
                                
                                
                            }
                        }
                            .frame(width: mainGeo.size.width * 0.75)
                        
                    }
                        .frame(width: mainGeo.size.width * 0.8)
                        .rotationEffect(.degrees(Double(simulator.totalTorque)))
                        .animation(.easeIn)
                    
                    
                    Text("Nivel derecho")
                        .frame(width: mainGeo.size.width * 0.1)
                }
                
            }
            
            Text(String(simulator.totalTorque))
            
        }
        
        
    }
}

struct SimulatorView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            SimulatorView()
        }
        
    }
}
