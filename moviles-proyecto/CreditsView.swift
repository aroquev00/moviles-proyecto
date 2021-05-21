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
        GeometryReader { mainGeo in
            ZStack {
                Color.white
                    //.resizable()
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                        VStack {
                            Text("Créditos")
                                .foregroundColor(Color.orange)
                                .fontWeight(.bold)
                                .font(.system(size: mainGeo.size.width * 0.07))
                            
                            Spacer()
                                .frame(height: mainGeo.size.height * 0.1)
                            Text("Notice")
                                .foregroundColor(Color.black)
                                .fontWeight(.bold)
                                .font(.system(size: mainGeo.size.width * 0.05))
                            Text("Halo © Microsoft Corporation. Equilibrium was created under Microsoft's \"Game Content Usage Rules\" using assets from Halo, and it is not endorsed by or affiliated with Microsoft.")
                                .font(.system(size: mainGeo.size.width * 0.03))
                                .foregroundColor(.mainTextForeground)
                            
                            Spacer()
                                .frame(height: mainGeo.size.height * 0.05)
                            
                            Text("Team members: Armando Roque, Eduardo Pineda, Guillermo García, Marco Brown")
                                .font(.system(size: mainGeo.size.width * 0.03))
                                .foregroundColor(.mainTextForeground)

                            Spacer()
                                .frame(height: mainGeo.size.height * 0.05)
                            
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Menu")
                                    .font(Font.custom("Bangers-Regular", size: (mainGeo.size.width * 0.05) + 10))
                                    .tracking(5)
                                    .frame(width: mainGeo.size.width * 0.28, height: mainGeo.size.height * 0.177)
                                    .background(Color.mainButtonBackground)
                                    .foregroundColor(.mainButtonTextForeground)
                                    .cornerRadius(20)
                            }
                            
                    }
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
