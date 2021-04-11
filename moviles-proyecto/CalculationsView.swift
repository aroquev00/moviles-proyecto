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
                
            }
        }
        
        
    }
}

struct CalculationsView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            CalculationsView(simulator: Simulator())
        }
    }
}
