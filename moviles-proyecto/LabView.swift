//
//  LabView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 24/03/21.
//

import SwiftUI

struct LabView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack {
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
