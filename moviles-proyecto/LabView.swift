//
//  LabView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 24/03/21.
//

import SwiftUI

struct LabView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var rotation: Double = 0.0
    
    var body: some View {
        ZStack {
            VStack {
                Text("Watch me rotate")
                    .rotationEffect(.degrees(rotation))
                    .padding()
                Slider(value: $rotation, in: -90...90)
                Text("Aquí va el lab")
                    .padding()
                Button("Dismiss Me") {
                    presentationMode.wrappedValue.dismiss()
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
