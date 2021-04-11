//
//  CalculationsView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 07/04/21.
//

import SwiftUI

struct CalculationsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let simulator: Simulator
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button {
                        // Return to lab view
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrowshape.turn.up.left.fill")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                    Spacer()
                    Text("Cálculos para el problema")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                    Spacer()
                }
                    .background(Color(.red))
                
                // Monitos
                // Lado Izquierdo
                VStack {
                    Text("Lado izquierdo")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.red)
                    ForEach(simulator.spots, id: \.self) { spot in
                        if !spot.side && spot.sprite != nil {
                            spriteDataView(spot: spot)
                        }
                    }
                }
                
                // Lado Derecho
                VStack {
                    Text("Lado derecho")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.blue)
                    ForEach(simulator.spots, id: \.self) { spot in
                        if spot.side && spot.sprite != nil {
                            spriteDataView(spot: spot)
                        }
                    }
                }
                
            }
        }
        
        
    }
    
    
}

struct spriteDataView: View {
    var spot: SimulatorSpot
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(spot.sprite!.name)
                Text(spriteInfo1(spot: spot))
                Text(spriteInfo2(spot: spot))
                Text(spriteInfo3(spot: spot))
            }
            Spacer()
            Image(uiImage: spot.sprite!.image!)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            Spacer()
        }
    }
    
    func spriteInfo1(spot: SimulatorSpot) -> String {
        let sprite = spot.sprite!
        return "Masa: \(sprite.weight) kg. - Distancia del centro: \(spot.distance) m."
    }
    
    func spriteInfo2(spot: SimulatorSpot) -> String {
        let sprite = spot.sprite!
        return "Torca ejercida = (\(sprite.weight) kg.) x (9.81 m/s\u{00B2}) x (\(spot.distance) m.)"
    }
    
    func spriteInfo3(spot: SimulatorSpot) -> String {
        let sprite = spot.sprite!
        let torque = sprite.weight * 9.81 * spot.distance
        return "Torca ejercida = \(String(format: "%.2f", torque)) Nm"
    }
}

struct CalculationsView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            CalculationsView(simulator: Simulator())
        }
    }
}
