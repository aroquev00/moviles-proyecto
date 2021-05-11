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
            $0.sprite != nil && $0.side == .left
        }
    }
    
    var rightSpots: [SimulatorSpot] {
        return simulator.spots.filter {
            $0.sprite != nil && $0.side == .right
        }
    }
    
    var body: some View {
        GeometryReader { mainGeo in
            ZStack {
                ScrollView {
                    VStack {
                        GeometryReader { geo in
                            HStack(spacing: 10) {
                                Button {
                                    // Return to lab view
                                    print(simulator.spots)
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Image(systemName: "arrowshape.turn.up.left.fill")
                                        .resizable()
                                        .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.6, blue: 0.07843137255, alpha: 1)))
                                }
                                Text("Cálculos para el problema")
                                    .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.06))
                                    .tracking(5)
                                    .frame(width: geo.size.width * 0.9, height: geo.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            }
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                            .background(Color(#colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.8, alpha: 1)))
                        }
                        .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        // Monitos
                        // Lado Izquierdo
                        GeometryReader { geo in
                            VStack {
                                Text("Lado izquierdo")
                                    .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.04))
                                    .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color(#colorLiteral(red: 0.01960784314, green: 0.4039215686, blue: 0.9098039216, alpha: 1)))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                    .cornerRadius(10)
                                if leftSpots.count > 0 {
                                    ForEach(leftSpots, id: \.self) { spot in
                                        
                                        spriteDataView(spot: spot)
                                        
                                    }
                                } else {
                                    Text("No se pusieron personajes del lado izquierdo")
                                        .font(.system(size: geo.size.width * 0.025))
                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                }
                            }
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        }
                        .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        // Lado Derecho
                        GeometryReader { geo in
                            VStack {
                                Text("Lado derecho")
                                    .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.04))
                                    .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color(#colorLiteral(red: 0.1490196078, green: 0.6784313725, blue: 0.6784313725, alpha: 1)))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                    .cornerRadius(10)
                                if rightSpots.count > 0 {
                                    ForEach(rightSpots, id: \.self) { spot in
                                        
                                        spriteDataView(spot: spot)
                                        
                                    }
                                } else {
                                    Text("No se pusieron personajes del lado derecho")
                                        .font(.system(size: geo.size.width * 0.025))
                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                }
                                
                            }
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        }
                        .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        // Resultado final
                        GeometryReader { geo in
                            VStack(spacing: 5) {
                                Text("Cálculo final")
                                    .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.04))
                                    .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color(#colorLiteral(red: 0.8509803922, green: 0.007843137255, blue: 0.007843137255, alpha: 1)))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                    .cornerRadius(10)

                                
                                // Left torque
                                let leftData = sideTorqueTotal(spots: leftSpots)
                                if leftSpots.count != 0 {
                                    Text("Torca izquierda = \(leftData.names!)")
                                        .font(.system(size: geo.size.width * 0.025))
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                    if leftSpots.count > 1 {
                                        Text("Torca izquierda = \(leftData.torques!)")
                                            .font(.system(size: geo.size.width * 0.025))
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                    }
                                }
                                Text("Torca izquierda = \(leftData.totalTorque)")
                                    .font(.system(size: geo.size.width * 0.025))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                
                                
                                // Right torque
                                let rightData = sideTorqueTotal(spots: rightSpots)
                                if rightSpots.count != 0 {
                                    Text("Torca derecha = \(rightData.names!)")
                                        .font(.system(size: geo.size.width * 0.025))
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                    if rightSpots.count > 1 {
                                        Text("Torca derecha = \(rightData.torques!)")
                                            .font(.system(size: geo.size.width * 0.025))
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                        
                                    }
                                }
                                Text("Torca derecha = \(rightData.totalTorque)")
                                    .font(.system(size: geo.size.width * 0.025))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
            
                                // Final result
                                if simulator.totalTorque == 0 {
                                    Text("Como las torcas izquierda y derecha son iguales, la tabla se mantiene en equilibrio.")
                                        .font(.system(size: geo.size.width * 0.025))
                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                } else if (simulator.totalTorque > 0) {
                                    Text("Como la torca derecha es mayor, se ladea hacia la derecha.")
                                        .font(.system(size: geo.size.width * 0.025))
                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                } else {
                                    Text("Como la torca izquierda es mayor, se ladea hacia la izquierda.")
                                        .font(.system(size: geo.size.width * 0.025))
                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                }
                                
                            }
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        }
                        .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
