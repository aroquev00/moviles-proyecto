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
            VStack {
                GeometryReader { geo in
                    HStack {
                        Text("EQUILIBRIUM")
                            .font(Font.custom("Bangers-Regular", size: 50))
                            .tracking(10)
                            .padding()
                            .frame(width: 499, height: 84, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.init(Color.RGBColorSpace.sRGB, red: 59/255, green: 40/255, blue: 204/255, opacity: 1.0))
                            .foregroundColor(.white)
                            .border(Color.init(Color.RGBColorSpace.sRGB, red: 169/255, green: 186/255, blue: 204/255, opacity: 1.0), width: 9)
                        Spacer()
                            .frame(width: 100)
                        Button(action: {
                            showCredits = true
                        }) {
                            Image("Zelda Logo")
                                .padding()
                                .frame(width: 102, height: 102)
                        }
                        .fullScreenCover(isPresented: $showCredits, content: {
                            CreditsView()
                        })
                    }
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.9)
                }
                .frame(height: 84)
                GeometryReader { geo in
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            showLab = true
                        }) {
                            Text("Lab")
                                .font(Font.custom("Bangers-Regular", size: 50))
                                .tracking(5)
                                //.padding()
                                .frame(width: 185, height: 65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 153/255, blue: 20/255, opacity: 1.0))
                                .foregroundColor(.white)
                                .fullScreenCover(isPresented: $showLab, content: {
                                    LabView()
                                })
                        }
                        
                        
                        Spacer()
                        
                        Button(action: {
                            showQuizMenu = true
                        }) {
                            Text("Quiz")
                                .font(Font.custom("Bangers-Regular", size: 50))
                                .tracking(5)
                                //.padding()
                                .frame(width: 185, height: 65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 153/255, blue: 20/255, opacity: 1.0))
                                .foregroundColor(.white)
                                .fullScreenCover(isPresented: $showQuizMenu, content: {
                                    QuizMenuView()
                                })
                        }
                        
                        
                        
                        Spacer()
                    }
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.7)
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
