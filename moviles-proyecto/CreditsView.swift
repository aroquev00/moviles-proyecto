//
//  CreditsView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 24/03/21.
//

import SwiftUI

struct CreditsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let firstLicencesTexts: [String] = [
        "Equilibrium has been developed by students from Tecnológico de Monterrey during the February June 2021 semester, as part of the course \"Desarrollo de Aplicaciones para Dispositivos Móviles\" and advised by teacher Yolanda Martínez Treviño.",
        "This means is not an official product of any proprietary of whom assets we used on this app.",
        "We do not possess any rights and properties of the assets used on this app.",
        "We do not use this app in any way to earn money and we do not endorse any asset being used in a commercial manner without the proper authorization of their respective proprietary (Microsoft, Mojang or Innersloth).",
        "Halo © Microsoft Corporation. Equilibrium was created under Microsoft's \"Game Content Usage Rules\" using assets from Halo, and it is not endorsed by or affiliated with Microsoft.",
        "Gears of War © Microsoft Corporation. Equilibrium was created under Microsoft's \"Game Content Usage Rules\" using assets from Gears of War, and it is not endorsed by or affiliated with Microsoft.",
        "Viva Piñata © Microsoft Corporation. Equilibrium was created under Microsoft's \"Game Content Usage Rules\" using assets from Viva Piñata, and it is not endorsed by or affiliated with Microsoft.",
        "Fable © Microsoft Corporation. Equilibrium was created under Microsoft's \"Game Content Usage Rules\" using assets from Fable, and it is not endorsed by or affiliated with Microsoft.",
        "To check and/or learn more about Microsoft's \"Game Content Usage Rules\", click here:",
    ]
    
    let secondLicencesTexts: [String] = [
        "NOT OFFICIAL MINECRAFT PRODUCT. NOT APPROVED BY OR ASSOCIATED WITH MOJANG.",
        "To check and/or learn more about Mojang's \"Brand and Assets Guidelines\", click here:"
    ]
    
    let thirdLicencesTexts: [String] = [
        "Among Us © Innersloth. Equilibrium was created under Innersloth's \"DMCA and Fan Creation Policy for Innersloth Licensed IP\" using assets from Ampng Us, and it is not endorsed by or affiliated with Innersloth.",
        "To check and/or learn more about Innersloth's \"DMCA and Fan Creation Policy for Innersloth Licensed IP\", click here:"
    ]
    
    let fourthLicencesTexts: [String] = [
        "Team members: Armando Roque, Eduardo Pineda, Guillermo García, Marco Brown",
        "Equilibrium is distributed as is free of charge and its distribution and use for profit is prohibited."
    ]
    
    var body: some View {
        GeometryReader { mainGeo in
            ZStack {
                Color.quizHelpBackground
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        Text("Créditos")
                            .font(Font.custom("Bangers-Regular", size: mainGeo.size.width * 0.06))
                            .tracking(5)
                            .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.15)
                            .foregroundColor(Color.mainTitleTextForeground)
                            .background(Color.mainTitleBackground)
                        
                        
                        Text("Notice")
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .font(.system(size: mainGeo.size.width * 0.05))
                        
                        VStack {
                            // First licences
                            ForEach(0..<firstLicencesTexts.count) { i in
                                Text(firstLicencesTexts[i])
                                    .font(.system(size: mainGeo.size.width * 0.03))
                                    .foregroundColor(Color.mainTextForeground)
                                Spacer()
                                    .frame(height: mainGeo.size.height * 0.05)
                            }
                            .multilineTextAlignment(.center)
                            .frame(width: mainGeo.size.width * 0.95)
                            
                            Link("Microsoft's Game Content Usage Rules", destination: URL(string: "https://www.xbox.com/en-US/developers/rules")!)
                                .font(.system(size: mainGeo.size.width * 0.03))
                            
                            Spacer()
                                .frame(height: mainGeo.size.height * 0.05)
                            
                            // Second licences
                            ForEach(0..<secondLicencesTexts.count) { i in
                                Text(secondLicencesTexts[i])
                                    .font(.system(size: mainGeo.size.width * 0.03))
                                    .foregroundColor(Color.mainTextForeground)
                                Spacer()
                                    .frame(height: mainGeo.size.height * 0.05)
                            }
                            .multilineTextAlignment(.center)
                            .frame(width: mainGeo.size.width * 0.95)
                            
                            Link("Mojang's Brand and Assets Guidelines", destination: URL(string: "https://account.mojang.com/terms")!)
                                .font(.system(size: mainGeo.size.width * 0.03))
                            
                            Spacer()
                                .frame(height: mainGeo.size.height * 0.05)
                            
                            
                            // Third licences
                            ForEach(0..<thirdLicencesTexts.count) { i in
                                Text(thirdLicencesTexts[i])
                                    .font(.system(size: mainGeo.size.width * 0.03))
                                    .foregroundColor(Color.mainTextForeground)
                                Spacer()
                                    .frame(height: mainGeo.size.height * 0.05)
                            }
                            .multilineTextAlignment(.center)
                            .frame(width: mainGeo.size.width * 0.95)
                            
                            
                            Link("DMCA and Fan Creation Policy for Innersloth Licensed IP", destination: URL(string: "https://store.innersloth.com/pages/dmca-and-fan-creation-policy-for-innersloth-licensed-ip")!)
                                .font(.system(size: mainGeo.size.width * 0.03))
                            
                            Spacer()
                                .frame(height: mainGeo.size.height * 0.05)
                            
                            // Fourth texts
                            ForEach(0..<fourthLicencesTexts.count) { i in
                                Text(fourthLicencesTexts[i])
                                    .font(.system(size: mainGeo.size.width * 0.03))
                                    .foregroundColor(Color.mainTextForeground)
                                Spacer()
                                    .frame(height: mainGeo.size.height * 0.05)
                            }
                            .multilineTextAlignment(.center)
                            .frame(width: mainGeo.size.width * 0.95)
                        }
                        
                        
                        
                        
                        GeometryReader { geo in
                            HStack {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Text("Menu")
                                        .font(Font.custom("Bangers-Regular", size: (mainGeo.size.width * 0.05) + 10))
                                        .tracking(5)
                                        .frame(width: mainGeo.size.width * 0.28, height: mainGeo.size.height * 0.177)
                                        .background(Color(#colorLiteral(red: 1, green: 0.6, blue: 0.07843137255, alpha: 1)))
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                        .cornerRadius(20)
                                }
                            }
                            .frame(width: geo.size.width, height: geo.size.height)
                        }
                        .frame(width: mainGeo.size.width, height: mainGeo.size.height * 0.2)
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
