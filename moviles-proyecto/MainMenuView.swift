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
        
        GeometryReader { mainGeo in
            ZStack(alignment: .center) {
                Image("Background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    GeometryReader { geo in
                        HStack {
                            Text("EQUILIBRIUM")
                                .font(Font.custom("Bangers-Regular", size: geo.size.height * 0.5))
                                .tracking(5)
                                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.7)
                                .background(Color.mainTitleBackground)
                                .foregroundColor(.mainTitleTextForeground)
                                .border(Color.mainTitleBackgroundBorder, width: 9)
                            
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    }
                    .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.3)
                    Spacer()
                        .frame(height: mainGeo.size.height * 0.3)
                    GeometryReader { geo in
                        HStack() {
                            Spacer()
                            Button(action: {
                                showLab = true
                            }) {
                                getButtonText(text: "Lab", geo: geo)
                            }
                            .fullScreenCover(isPresented: $showLab, content: {
                                LabView()
                            })
                            Spacer()
                            Button(action: {
                                showQuizMenu = true
                            }) {
                                getButtonText(text: "Quiz", geo: geo)
                            }
                            .fullScreenCover(isPresented: $showQuizMenu, content: {
                                QuizMenuView()
                            })
                            Spacer()
                            Button(action: {
                                showCredits = true
                            }) {
                                getButtonText(text: "Créditos", geo: geo)

                            }
                            .fullScreenCover(isPresented: $showCredits, content: {
                                CreditsView()
                            })
                            Spacer()
                        }
                        .frame(width: mainGeo.size.width)
                    }
                    .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.2)
                }
                .frame(width: mainGeo.size.width, height: mainGeo.size.height)
            }
        }
//        .onAppear {
//            print("A")
//            AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
//            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//            UINavigationController.attemptRotationToDeviceOrientation()
//        }
//        .onDisappear {
//            DispatchQueue.main.async {
//                AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
//                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//                UINavigationController.attemptRotationToDeviceOrientation()
//            }
//        }
    }
    
    // Function to get the Text for each button
    func getButtonText(text: String, geo: GeometryProxy) -> some View {
        return Text(text)
            .font(Font.custom("Bangers-Regular", size: geo.size.height * 0.5))
            .tracking(5)
            //.padding()
            .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.785)
            .background(Color.mainButtonBackground)
            .foregroundColor(.mainButtonTextForeground)
            .cornerRadius(20)
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
