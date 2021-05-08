//
//  CalculationsView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 07/04/21.
//

import SwiftUI

struct CalculationsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var simulator: Simulator
    
    var leftSpots: [SimulatorSpot] {
        return simulator.spots.filter {
            $0.sprite != nil && !$0.side
        }
    }
    
    var rightSpots: [SimulatorSpot] {
        return simulator.spots.filter {
            $0.sprite != nil && $0.side
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button {
                        // Return to lab view
                        print(simulator.spots)
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
                    if leftSpots.count > 0 {
                        ForEach(leftSpots, id: \.self) { spot in
                            
                            spriteDataView(spot: spot)
                            
                        }
                    } else {
                        Text("No se pusieron personajes del lado izquierdo")
                    }
                }
                
                // Lado Derecho
                VStack {
                    Text("Lado derecho")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.blue)
                    if rightSpots.count > 0 {
                        ForEach(rightSpots, id: \.self) { spot in
                            
                            spriteDataView(spot: spot)
                            
                        }
                    } else {
                        Text("No se pusieron personajes del lado derecho")
                    }
                    
                }
                
                // Resultado final
                VStack {
                    Text("Cálculo final")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.green)
                    
                    // Left torque
                    let leftData = sideTorqueTotal(spots: leftSpots)
                    if leftSpots.count != 0 {
                        Text("Torca izquierda = \(leftData.names!)")
                        if leftSpots.count > 1 {
                            Text("Torca izquierda = \(leftData.torques!)")
                        }
                    }
                    Text("Torca izquierda = \(leftData.totalTorque)")
                        .foregroundColor(.red)
                    
                    Spacer()
                    
                    // Right torque
                    let rightData = sideTorqueTotal(spots: rightSpots)
                    if rightSpots.count != 0 {
                        Text("Torca derecha = \(rightData.names!)")
                        if rightSpots.count > 1 {
                            Text("Torca derecha = \(rightData.torques!)")
                        }
                    }
                    Text("Torca derecha = \(rightData.totalTorque)")
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    // Final result
                    if simulator.totalTorque == 0 {
                        Text("Como las torcas izquierda y derecha son iguales, la tabla se mantiene en equilibrio.")
                    } else if (simulator.totalTorque > 0) {
                        Text("Como la torca derecha es mayor, se ladea hacia la derecha.")
                    } else {
                        Text("Como la torca izquierda es mayor, se ladea hacia la izquierda.")
                    }
                    
                }
            }
        }
    }
    
    func sideTorqueTotal(spots: [SimulatorSpot]) -> (names: String?, torques: String?, totalTorque: String) {
        if spots.count == 0 {
            return (nil, nil, "0 Nm")
        } else {
            var names: String = ""
            var torques: String = ""
            var totalTorque: Float = 0.0
            
            for (index, spot) in spots.enumerated() {
                // Add to the names
                names += "Torca \(spot.sprite!.name)"
                
                
                // Add to the description of torques and total torque
                let spriteTorque = spot.sprite!.weight * 9.81 * spot.distance
                
                torques += "\(String(format: "%.2f", spriteTorque)) Nm"
                
                totalTorque += spriteTorque
                
                // Add + signs to strings if needed
                if index != spots.count - 1 {
                    names += " + "
                    torques += " + "
                }
            }
            return (names, torques, String(format: "%.2f", totalTorque) + " Nm")
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
            Image(uiImage: UIImage(named: spot.sprite!.imageURL)!)
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
            CalculationsView(simulator: .constant(Simulator(quizMode: false)))
        }
    }
}
