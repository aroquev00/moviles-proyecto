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
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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


