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
                // MARK: Left level indicator
                getLevelView(symbolName: "arrowtriangle.right.fill", width: mainGeo.size.width * 0.05)
                
                // MARK: - Tabla, base and columns start
                let barWidth = mainGeo.size.width * 0.9
                let barHeight = barWidth * (183 / 3040)
                ZStack {
                    // MARK: Tabla base
                    Image("base2")
                        .resizable()
                        .scaledToFit()
                    
                    // MARK: Columns
                    HStack {
                        getColumnView()
                        Spacer()
                        getColumnView()
                    }
                    .frame(width: mainGeo.size.width * 0.75)
                    
                    ZStack {
                        // MARK: Tabla
                        Image(simulator.rulerEnabled ?  "tablaRegla" : "tabla")
                            .resizable()
                            .scaledToFit()
                        
                        // MARK: - Simulator spots
                        ZStack() {
                            // MARK: Sprites
                            let spriteAreaHeight = (mainGeo.size.height / 2) - (barHeight / 2)
                            ForEach(simulator.spots, id: \.self) { spot in
                                if let sprite = spot.sprite {
                                    VStack(spacing: 0) {
                                        Spacer()
                                        if (spot.showWeight) {
                                            //Text(String(spot.index))
                                            Text(String(format: (floor(sprite.weight) == sprite.weight ? "%.0f" : "%.2f"), sprite.weight))
                                                .font(Font.custom("Bangers-Regular", size: spriteAreaHeight * 0.15))
                                                .foregroundColor(.white)
                                        } else {
                                            Text("?")
                                                .font(Font.custom("Bangers-Regular", size: spriteAreaHeight * 0.15))
                                                .foregroundColor(.white)
                                        }
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
                                            Image(uiImage: UIImage(named: sprite.imageURL)!)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: (spriteAreaHeight * 0.85 * getSpriteHeight(spot: spot)))
                                        }
                                    }
                                    .frame(height: spriteAreaHeight)
                                    //.border(Color.black)
                                    .position(x: barWidth / 18 * CGFloat(spot.index + (spot.index >= 8 ? 2 : 1)), y: mainGeo.size.height / 2) // Needs work
                                    .offset(y: -(spriteAreaHeight / 2 + barHeight / 2))
                                }
                            }
                        }
                        
                        // MARK: Buttons
                        HStack(spacing: 0.0) {
                            getSpotButtonsView(side: .left, barWidth: barWidth, barHeight: barHeight)
                            Spacer()
                                .frame(width: barWidth / 18)
                            getSpotButtonsView(side: .right, barWidth: barWidth, barHeight: barHeight)
                        }
                        
                    }
                    .rotationEffect(
                        simulator.totalTorque > 20 ? .degrees(Double(20)) : (simulator.totalTorque < -20 ? .degrees(Double(-20))  : .degrees(Double(simulator.totalTorque)))
                    )
                    .animation(.easeIn)
                }
                // MARK: - Tabla, base and columns end
                
                // MARK: Right level indicator
                getLevelView(symbolName: "arrowtriangle.left.fill", width: mainGeo.size.width * 0.05)
            }
            .frame(width: mainGeo.size.width, height: mainGeo.size.height)
        }
    }
    
    // MARK: - View helper functions
    
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
    
    func getSpotButtonsView(side: Side, barWidth: CGFloat, barHeight: CGFloat) -> some View {
        ForEach(simulator.spots, id: \.self) { spot in
            if (side == .left ? { spot.index <= 7 } : { spot.index >= 8 })() {
                Button {
                    if (!spot.isLocked) {
                        if simulator.quizMode {
                            if let previousIndex = simulator.placedSpriteIndex {
                                simulator.spots[previousIndex].sprite = nil
                            }
                            simulator.placedSpriteIndex = spot.index
                        }
                        simulator.spots[spot.index].sprite = simulator.selectedSprite
                        //print(spot.index)
                    }
                } label: {
                    //Text(String(spot.index))
                    Rectangle()
                        .fill(Color(.sRGB, red: 1, green: 1, blue: 1, opacity: 0))
                        //.border(Color.black) // for debug
                        .frame(width: barWidth / 18, height: barHeight)
                    
                }
            }
        }
    }
    
    // MARK: - Additional helper functions
    
    func getSpriteHeight(spot: SimulatorSpot) -> CGFloat {
        return CGFloat((spot.sprite?.height)!)
    }
}

struct SimulatorView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            SimulatorView(simulator: .constant(Simulator(quizMode: false)))
        }
        
    }
}
