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
        GeometryReader { mainGeo in
            ZStack {
                ScrollView {
                        VStack {
                            GeometryReader { geo in
                                HStack {
                                    Text("Notice")
                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                        .fontWeight(.bold)
                                        .font(.system(size: geo.size.width * 0.07))
                                }
                                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                            }
                            .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.2, alignment: .center)
                            
                            GeometryReader { geo in
                                HStack {
                                    Text("Halo © Microsoft Corporation. Equilibrium was created under Microsoft's \"Game Content Usage Rules\" using assets from Halo, and it is not endorsed by or affiliated with Microsoft.")
                                        .font(.system(size: geo.size.width * 0.03))
                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                }
                                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                            }
                            .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.2, alignment: .center)
                            
                            GeometryReader { geo in
                                HStack {
                                    Text("Team members: Armando Roque, Eduardo Pineda, Guillermo García, Marco Brown")
                                        .font(.system(size: geo.size.width * 0.03))
                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                }
                                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                            }
                            .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                            GeometryReader { geo in
                                HStack {
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Text("Menu")
                                            .font(Font.custom("Bangers-Regular", size: (geo.size.width * 0.05) + 10))
                                            .tracking(5)
                                            .frame(width: geo.size.width * 0.28, height: geo.size.height * 0.885, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .background(Color(#colorLiteral(red: 1, green: 0.6, blue: 0.07843137255, alpha: 1)))
                                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                            .cornerRadius(20)
                                            .fullScreenCover(isPresented: $showMenu, content: {
                                                MainMenuView()
                                            })
                                    }
                                }
                                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                            }
                            .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
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


