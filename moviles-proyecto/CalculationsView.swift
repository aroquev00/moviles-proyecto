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
                Color.blue
                    //.resizable()
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        GeometryReader { geo in
                            HStack(spacing: 10) {
                                Spacer()
                                Button {
                                    // Return to lab view
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Image(systemName: "arrowshape.turn.up.left.fill")
                                        .resizable()
                                        .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.4)
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.6, blue: 0.07843137255, alpha: 1)))
                                }
                                Text("Cálculos para el problema")
                                    .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.06))
                                    .tracking(5)
                                    .frame(width: geo.size.width, height: geo.size.height)
                                    .foregroundColor(.mainTitleTextForeground)
                            }
                            .background(Color.mainTitleBackground)
                        }
                        .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.2)
                        
                        // Monitos
                        // Lado Izquierdo
                        VStack {
                            getSectionTitle(title: "Lado izquierdo", foregroundColor: Color(#colorLiteral(red: 0.01960784314, green: 0.4039215686, blue: 0.9098039216, alpha: 1)), geo: mainGeo)
                            
                            if leftSpots.count > 0 {
                                ForEach(leftSpots, id: \.self) { spot in
                                    spriteDataView(spot: spot, geo: mainGeo)
                                }
                            } else {
                                Text("No se pusieron personajes del lado izquierdo")
                                    .font(.system(size: mainGeo.size.width * 0.025))
                                    .foregroundColor(.mainTextForeground)
                            }
                        }
                        
                        // Lado Derecho
                        VStack {
                            getSectionTitle(title: "Lado derecho", foregroundColor: Color(#colorLiteral(red: 0.1490196078, green: 0.6784313725, blue: 0.6784313725, alpha: 1)), geo: mainGeo)
                            if rightSpots.count > 0 {
                                ForEach(rightSpots, id: \.self) { spot in
                                    spriteDataView(spot: spot, geo: mainGeo)
                                }
                            } else {
                                Text("No se pusieron personajes del lado derecho")
                                    .font(.system(size: mainGeo.size.width * 0.025))
                                    .foregroundColor(.mainTextForeground)
                            }
                        }
                        
                        // Resultado final
                        VStack(spacing: 5) {
                            getSectionTitle(title: "Cálculo final", foregroundColor: Color(#colorLiteral(red: 0.8509803922, green: 0.007843137255, blue: 0.007843137255, alpha: 1)), geo: mainGeo)

                            // Left torque
                            let leftData = sideTorqueTotal(spots: leftSpots)
                            if leftSpots.count != 0 {
                                Text("Torca izquierda = \(leftData.names!)")
                                    .font(.system(size: mainGeo.size.width * 0.025))
                                    .fontWeight(.bold)
                                    .foregroundColor(.mainTextForeground)
                                if leftSpots.count > 1 {
                                    Text("Torca izquierda = \(leftData.torques!)")
                                        .font(.system(size: mainGeo.size.width * 0.025))
                                        .fontWeight(.bold)
                                        .foregroundColor(.mainTextForeground)
                                }
                            }
                            Text("Torca izquierda = \(leftData.totalTorque)")
                                .font(.system(size: mainGeo.size.width * 0.025))
                                .fontWeight(.bold)
                                .foregroundColor(.mainTextForeground)
                            
                            
                            // Right torque
                            let rightData = sideTorqueTotal(spots: rightSpots)
                            if rightSpots.count != 0 {
                                Text("Torca derecha = \(rightData.names!)")
                                    .font(.system(size: mainGeo.size.width * 0.025))
                                    .fontWeight(.bold)
                                    .foregroundColor(.mainTextForeground)
                                if rightSpots.count > 1 {
                                    Text("Torca derecha = \(rightData.torques!)")
                                        .font(.system(size: mainGeo.size.width * 0.025))
                                        .fontWeight(.bold)
                                        .foregroundColor(.mainTextForeground)
                                    
                                }
                            }
                            Text("Torca derecha = \(rightData.totalTorque)")
                                .font(.system(size: mainGeo.size.width * 0.025))
                                .fontWeight(.bold)
                                .foregroundColor(.mainTextForeground)
        
                            // Final result
                            if simulator.totalTorque == 0 {
                                Text("Como las torcas izquierda y derecha son iguales, la tabla se mantiene en equilibrio.")
                                    .font(.system(size: mainGeo.size.width * 0.025))
                                    .foregroundColor(.mainTextForeground)
                            } else if (simulator.totalTorque > 0) {
                                Text("Como la torca derecha es mayor, se ladea hacia la derecha.")
                                    .font(.system(size: mainGeo.size.width * 0.025))
                                    .foregroundColor(.mainTextForeground)
                            } else {
                                Text("Como la torca izquierda es mayor, se ladea hacia la izquierda.")
                                    .font(.system(size: mainGeo.size.width * 0.025))
                                    .foregroundColor(.mainTextForeground)
                            }
                            
                        }
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
    
    // Function that returns the Text with the title for the section
    func getSectionTitle(title: String, foregroundColor: Color, geo: GeometryProxy) -> some View {
        Text(title)
            .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.04))
            .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.105)
            .background(foregroundColor)
            .foregroundColor(.mainTitleTextForeground)
            .cornerRadius(10)
    }
}

struct spriteDataView: View {
    var spot: SimulatorSpot
    var geo: GeometryProxy
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: geo.size.width * 0.05)
            VStack(alignment: .leading) {
                Text(spot.sprite!.name)
                Text(spriteInfo1(spot: spot))
                Text(spriteInfo2(spot: spot))
                Text(spriteInfo3(spot: spot))
            }
            .foregroundColor(.mainTitleTextForeground)
            Spacer()
            Image(uiImage: UIImage(named: spot.sprite!.imageURL)!)
                .resizable()
                .scaledToFit()
                .frame(height: geo.size.height * 0.25)
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
