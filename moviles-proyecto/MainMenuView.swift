//
//  MainMenuView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 19/03/21.
//

import SwiftUI

struct MainMenuView: View {
    
    @State var showCredits: Bool = false
    @State var showLab: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Equilibrium")
                        .padding()
                    Button(action: {
                        showCredits = true
                    }) {
                        Text("Créditos")
                    }
                    .sheet(isPresented: $showCredits, content: {
                        CreditsView()
                    })
                }
                HStack {
                    Button(action: {
                        showLab = true
                    }) {
                        Text("Laboratorio")
                    }
                    .sheet(isPresented: $showLab, content: {
                        LabView()
                    })
                    
                }
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            MainMenuView()
        }
        
    }
}

struct Landscape<Content>: View where Content: View {
    let content: () -> Content
    let height = UIScreen.main.bounds.width //toggle width height
    let width = UIScreen.main.bounds.height
    var body: some View {
        content().previewLayout(PreviewLayout.fixed(width: width, height: height))
    }
}
