//
//  LabView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 24/03/21.
//

import SwiftUI

struct LabView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showCalculations: Bool = false
    
//    Sprite array
    let spritesRow = [
        Sprite(name: "Mario", weight: 20, height: 1, image: UIImage(named: "mario")),
        Sprite(name: "Kirby", weight: 10, height: 1, image: UIImage(named: "kirby")),
        Sprite(name: "Steve", weight: 30, height: 1, image: UIImage(named: "steve")),
        Sprite(name: "Master Chief", weight: 80, height: 1, image: UIImage(named: "masterchief")),
        Sprite(name: "Plankton", weight: 5, height: 1, image: UIImage(named: "plankton")),
        Sprite(name: "Sonic", weight: 15, height: 1, image: UIImage(named: "sonic")),
        Sprite(name: "Link", weight: 60, height: 1, image: UIImage(named: "link")),
        Sprite(name: "Megaman", weight: 20, height: 1, image: UIImage(named: "megaman"))
    ]
    
    // Data structure to store placed characters
    @State var simulator: Simulator = Simulator()
    
    @State var indexSelectedSprite: Int? = nil
    
    var body: some View {
        ZStack {
            // Aquí va el fondo del juego
            Image("Background2")
                .resizable()
                        .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geo in
                VStack {
                    HStack {
                        SimulatorView(simulator: $simulator)
                            .frame(width: geo.size.width * 0.8)
                        VStack {
                            Spacer()
                            HStack {
                                // Buttons
                                Spacer()
                                Button {
                                    // Return to home
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Image(systemName: "house.fill")
                                        .foregroundColor(.blue)
                                        .font(.title)
                                }
                                Spacer()
                                Button {
                                    // Reset simulator
                                    simulator.reset()
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(Color.red)
                                        .font(.title)
                                }
                                Spacer()
                            }
                            Spacer()
                            Toggle(isOn: $simulator.columnsEnabled) {
                                Text("Columnas")
                            }
                            Spacer()
                            Toggle(isOn: $simulator.rulerEnabled) {
                                Text("Regla")
                            }
                            Spacer()
                            Button {
                                // Show calc screen
                                showCalculations = true
                                
                            } label: {
                                Text("Ver cálculos ⚙️")
                            }
                            .sheet(isPresented: $showCalculations, content: {
                                CalculationsView(simulator: $simulator)
                            })
                        }
                            .frame(width: geo.size.width * 0.2)
                        
                    }
                    .frame(height: geo.size.height / 1.5)
                    
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(0..<spritesRow.count) { i in
                                Button {
                                    if indexSelectedSprite != i {
                                        // User just selected this sprite
                                        simulator.selectedSprite = spritesRow[i]
                                        indexSelectedSprite = i
                                    } else {
                                        // User is toggling this sprite
                                        indexSelectedSprite = nil
                                        simulator.selectedSprite = nil
                                    }
                                } label: {
                                    VStack {
                                        Image(uiImage: spritesRow[i].image!)
                                            .resizable()
                                            .scaledToFit()
                                        Text(String(spritesRow[i].weight) + " kg")
                                    }
                                    .background(Color.red.opacity(indexSelectedSprite == i ? 1.0 : 0.0)) // Background is red if sprite is selected to be placed in simulator
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct LabView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            LabView()
        }
    }
}
