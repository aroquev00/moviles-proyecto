//
//  LabView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 24/03/21.
//

import SwiftUI

struct LabView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showRuler: Bool = true
    
//    Sprite array
    let spritesRow = [
        Sprite(name: "Mario", weight: 20, height: 1, image: UIImage(named: "mario")),
        Sprite(name: "Kirby", weight: 10, height: 1, image: UIImage(named: "kirby")),
        Sprite(name: "Steve", weight: 30, height: 1, image: UIImage(named: "steve")),
        Sprite(name: "Master Chief", weight: 80, height: 1, image: UIImage(named: "masterchief")),
        Sprite(name: "Plankton", weight: 50, height: 1, image: UIImage(named: "plankton")),
        Sprite(name: "Sonic", weight: 15, height: 1, image: UIImage(named: "sonic")),
        Sprite(name: "Link", weight: 60, height: 1, image: UIImage(named: "link")),
        Sprite(name: "Megaman", weight: 20, height: 1, image: UIImage(named: "megaman"))
    ]
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack {
                    HStack {
                        SimulatorView()
                            .frame(width: geo.size.width * 0.8)
                        VStack {
                            HStack {
//                                Buttons
                            }
                            Text("Panel derecho")
                            Toggle(isOn: $showRuler) {
                                Text("Regla")
                            }
                        }
                            .frame(width: geo.size.width * 0.2)
                        
                    }
                    .frame(height: geo.size.height / 1.5)
                    
                    Button("Dismiss Me") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(0..<spritesRow.count) { i in
                                VStack {
                                    //Text(spritesRow[i].name)
                                    Image(uiImage: spritesRow[i].image!)
                                        .resizable()
                                        .scaledToFit()
                                    Text(String(spritesRow[i].weight) + " kg")
        //                                .foregroundColor(.white)
        //                                .font(.largeTitle)
        //                                .background(Color.red)
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
