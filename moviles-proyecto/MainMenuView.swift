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
    @State var showQuizMenu: Bool = false
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
            GeometryReader { mainGeo in
                VStack {
                    GeometryReader { geo in
                        HStack {
                            Text("EQUILIBRIUM")
                                .font(Font.custom("Bangers-Regular", size: geo.size.width * 0.065))
                                .tracking(5)
                                .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color(#colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.8, alpha: 1)))
                                .foregroundColor(.white)
                                .border(Color.init(Color.RGBColorSpace.sRGB, red: 169/255, green: 186/255, blue: 204/255, opacity: 1.0), width: 9)
                            
                        }
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    }
                    .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer().frame(height: mainGeo.size.height * 0.35)
                    GeometryReader { geo in
                        HStack(spacing: 75) {
                            Button(action: {
                                showLab = true
                            }) {
                                Text("Lab")
                                    .font(Font.custom("Bangers-Regular", size: (geo.size.width * 0.05) - 3))
                                    .tracking(5)
                                    //.padding()
                                    .frame(width: geo.size.width * 0.18, height: geo.size.height * 0.785, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 153/255, blue: 20/255, opacity: 1.0))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .fullScreenCover(isPresented: $showLab, content: {
                                        LabView()
                                    })
                            }
                            Button(action: {
                                showQuizMenu = true
                            }) {
                                Text("Quiz")
                                    .font(Font.custom("Bangers-Regular", size: (geo.size.width * 0.05) - 3))
                                    .tracking(5)
                                    .frame(width: geo.size.width * 0.18, height: geo.size.height * 0.785, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 153/255, blue: 20/255, opacity: 1.0))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .fullScreenCover(isPresented: $showQuizMenu, content: {
                                        QuizMenuView()
                                    })
                            }
                            Button(action: {
                                showCredits = true
                            }) {
                                Text("Creditos")
                                    .font(Font.custom("Bangers-Regular", size: (geo.size.width * 0.05) - 6))
                                    .tracking(3)
                                    .frame(width: geo.size.width * 0.18, height: geo.size.height * 0.785, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 153/255, blue: 20/255, opacity: 1.0))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .fullScreenCover(isPresented: $showCredits, content: {
                                        CreditsView()
                                    })
                            }
                        }
                        .frame(maxWidth: geo.size.width, maxHeight: geo.size.height, alignment: .center)
                    }
                    .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.2, alignment: .center)
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
