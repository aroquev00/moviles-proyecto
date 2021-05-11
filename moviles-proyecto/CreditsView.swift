//
//  CreditsView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 24/03/21.
//

import SwiftUI

struct CreditsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showMenu: Bool = false
    
    
    var body: some View {
        ZStack {
            GeometryReader { mainGeo in
                VStack {
                    Spacer().frame(height: 20)
                    GeometryReader { geo in
                        HStack {
                            Text("Notice")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .font(.system(size: 70))
                                .fixedSize()
                        }
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    }
                    .frame(height: 41.5)
                    
                    Spacer().frame(height: 25)
                    GeometryReader { geo in
                        HStack {
                            Text("Halo © Microsoft Corporation. Equilibrium was created under Microsoft's \"Game Content Usage Rules\" using assets from Halo, and it is not endorsed by or affiliated with Microsoft.")
                                .font(Font.custom("Open Sans Hebrew", size: 30))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)

                        }
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .leading)
                    }
                    .frame(height: 103.5)
                    Spacer().frame(height: 50)
                    GeometryReader { geo in
                        HStack {
                            Text("Team members: Armando Roque, Eduardo Pineda, Guillermo García, Marco Brown")
                                .font(Font.custom("Open Sans Hebrew", size: 30))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)

                        }
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .leading)
                    }
                    .frame(height: 69)

                    Spacer().frame(height: 25)
                    GeometryReader { geo in
                        HStack {
                            Button(action: {
                                showMenu = true
                            }) {
                                Text("Menu")
                                    .font(Font.custom("Bangers-Regular", size: 50))
                                    .tracking(5)
                                    .frame(width: 185, height: 65, alignment: .center)
                                    .background(Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 153/255, blue: 20/255, opacity: 1.0))
                                    .foregroundColor(.white)
                                    .fullScreenCover(isPresented: $showMenu, content: {
                                        MainMenuView()
                                    })
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    }
                    .frame(height: 65)
                    
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


