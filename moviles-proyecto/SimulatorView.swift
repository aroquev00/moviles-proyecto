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
        GeometryReader { mainGeo in
            HStack(spacing: 0.0) {
                // Left level indicator
                getLevelView(symbolName: "arrowtriangle.right.fill", width: mainGeo.size.width * 0.05)
                
                // MARK: - Tabla, base y columnas
                ZStack {
                    // MARK: Base de la tabla
                    Image("base2")
                        .resizable()
                        .scaledToFit()
                    
                    // MARK: Columnas
                    HStack {
                        getColumnView()
                        Spacer()
                        getColumnView()
                    }
                    .frame(width: mainGeo.size.width * 0.75, height: mainGeo.size.height, alignment: .center)
                    //.offset(x: 0.0, y: mainGeo.size.height * 0.23)
                    
                    ZStack {
                        let barWidth = mainGeo.size.width * 0.75
                        
                        
                        Image(simulator.rulerEnabled ?  "tablaRegla" : "tabla")
                            .resizable()
                            .scaledToFit()
                        
                        
                        ZStack { // Sprites
                            
                            ForEach(simulator.spots, id: \.self) { spot in
                                if let sprite = spot.sprite {
                                    VStack {
                                        if (spot.showWeight) {
                                            Text("\(String(format: "%.2f", sprite.weight))\n kg")
                                                .foregroundColor(.red)
                                        } else {
                                            Text("?")
                                        }
                                        
                                        Image(uiImage: UIImage(named: sprite.imageURL)!)
                                            .resizable()
                                            .scaledToFit()
                                        //.frame(width: barWidth/16, height: mainGeo.size.height / 3, alignment: .center)
                                        
                                        
                                        //.offset(y: -45)
                                        //.padding(-15)
                                        //.position(x: 50)
                                        //.padding(EdgeInsets(top: 0, leading: -barWidth/16 - 1, bottom: 0, trailing: -barWidth/16 - 1))
                                    }
                                    .frame(height: mainGeo.size.height / 3, alignment: .center)
                                    .position(x: barWidth / 16 * CGFloat(spot.index + 1), y: mainGeo.size.height/2 - 45) // Needs work
                                    
                                }
                            }
                            
                        }
                        
                        HStack() { // Buttons
                            ForEach(simulator.spots, id: \.self) { spot in
                                Button {
                                    if (!spot.isLocked) {
                                        if simulator.quizMode {
                                            if let previousIndex = simulator.placedSpriteIndex {
                                                simulator.spots[previousIndex].sprite = nil
                                            }
                                            simulator.placedSpriteIndex = spot.index
                                        }
                                        simulator.spots[spot.index].sprite = simulator.selectedSprite
                                    }
                                } label: {
                                    Text( "|"
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
                }
                
                // Right level indicator
                getLevelView(symbolName: "arrowtriangle.left.fill", width: mainGeo.size.width * 0.05)
            }
            .frame(width: mainGeo.size.width, height: mainGeo.size.height)
        }
    }
    
    // Function to return a View containing the triangle for the balance level
    func getLevelView(symbolName: String, width: CGFloat) -> some View {
        return Image(systemName: symbolName)
            .foregroundColor(simulator.totalTorque == 0 ? .green : .gray)
            .font(.largeTitle)
            .frame(width: width)
    }
    
    func getColumnView() -> some View {
        return Image("columna2")
            .resizable()
            .scaledToFit()
            .opacity(simulator.columnsEnabled ? 1.0 : 0.0)
            .animation(.easeIn)
    }
}

struct SimulatorView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            SimulatorView(simulator: .constant(Simulator(quizMode: false)))
        }
        
    }
}
