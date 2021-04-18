//
//  QuizView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("This is a quiz")
            Button("Dismiss Me") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            QuizView()
        }
    }
}
