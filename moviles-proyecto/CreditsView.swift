//
//  CreditsView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 24/03/21.
//

import SwiftUI

struct CreditsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Creditos")
                        .padding()
                        .font(Font.custom("Open Sans Hebrew", size: 36))
                }
                Text("Hello, World!")
                Button("Dismiss Me") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            CreditsView()
        }
    }
}


