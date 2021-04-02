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
            ZStack {
                //Color(.red)
                Image("line")
                
                HStack {
                    ForEach(simulator.spots, id: \.self) { spot in
                        Button {
                            simulator.spots[spot.index].sprite = Sprite(name: "Mario", weight: 20, height: 1, image: UIImage(named: "mario"))
                        } label: {
                            Text(String(spot.distance))
                        }
                        
                    }
                }
//                VStack {
//
//                    HStack {
//                        ForEach(Array(stride(from: -2, to: 2.25, by: 0.25)), id: \.self) { number in
//                            Button {
//                                showingAlert = true
//                                selectedNumber = number
//                            } label: {
//                                Text(String(number))
//                                    .font(.system(size: 12))
//                            }
//                            .alert(isPresented: $showingAlert) {
//                                        Alert(title: Text("Se dio click"), message: Text(String(selectedNumber)), dismissButton: .default(Text("Got it!")))
//                                    }
//
//
//                        }
//    //                    ForEach(Array(stride(from: -2, to: 2, by: 0.25)), id: \.self) {
//    //                        Text(String(id))
//    //                    }
//    //                    Text("Hi")
//    //                        .foregroundColor(.black)
//    //                    Text("2")
//    //                        .foregroundColor(.black)
//                    }
//                }
                
                
                
            }
            .rotationEffect(.degrees(Double(simulator.totalTorque)))
            .animation(.easeIn)
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
