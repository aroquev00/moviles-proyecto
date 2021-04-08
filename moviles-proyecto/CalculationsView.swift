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
        ZStack {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Button("Dismiss Me") {
                    presentationMode.wrappedValue.dismiss()
                }
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
