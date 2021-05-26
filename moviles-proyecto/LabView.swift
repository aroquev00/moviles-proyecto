//
//  LabView.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 24/03/21.
//

import SwiftUI

struct LabView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showCalculations: Bool = false
    
    //    Sprite array
    let spritesRow = Array(SpriteFactory.all)
    
    // Data structure to store placed characters
    @State var simulator: Simulator = Simulator(quizMode: false)
    
    @State var indexSelectedSprite: Int? = nil
    
    var body: some View {
        ZStack {
            // Aquí va el fondo del juego
            Image("Background2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geo in
                VStack() {
                    HStack(spacing: 0.0) {
                        SimulatorView(simulator: $simulator)
                            .frame(width: geo.size.width * 0.8)
                        
                        // MARK: - Side menu
                        GeometryReader { sideGeo in
                            let switchesVerticalPadding: CGFloat = sideGeo.size.height * 0.03
                            VStack {
                                Spacer()
                                ZStack {
                                    //Image("blue").resizable()
                                    // .frame(width: geo.size.width * 0.19)
                                    HStack {
                                        // Buttons
                                        Spacer()
                                        Button {
                                            // Return to home
                                            presentationMode.wrappedValue.dismiss()
                                        } label: {
                                            Image(systemName: "house.fill")
                                                .resizable()
                                                .foregroundColor(.white)
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: sideGeo.size.width * 0.35, height: sideGeo.size.height * 0.15)
                                        }
                                        Spacer()
                                        Button {
                                            // Reset simulator
                                            simulator.reset()
                                        } label: {
                                            Image(systemName: "trash")
                                                .resizable()
                                                .foregroundColor(Color.red)
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: sideGeo.size.width * 0.3, height: sideGeo.size.height * 0.15)
                                        }
                                        Spacer()
                                    }
                                    .frame(width: sideGeo.size.width, height: sideGeo.size.height * 0.2)
                                    .background(Color(#colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.8, alpha: 1)))
                                    .cornerRadius(10)
                                }
                                
                                Spacer()
                                // MARK: Columns switch
                                HStack {
                                    Spacer()
                                    Image("columnaSwitch")
                                        .resizable()
                                        .scaledToFit()
                                    Spacer()
                                    Toggle("", isOn: Binding<Bool>(
                                            get: {return !self.simulator.columnsEnabled},
                                            set: {noColumns in self.simulator.columnsEnabled = !noColumns})
                                    )
                                    .labelsHidden()
                                    Spacer()
                                    Image("columnaSwitchCrossed")
                                        .resizable()
                                        .scaledToFit()
                                    Spacer()
                                }
                                .frame(width: sideGeo.size.width, height: sideGeo.size.height * 0.15)
                                .padding(EdgeInsets(top: switchesVerticalPadding, leading: 0, bottom: switchesVerticalPadding, trailing: 0))
                                .background(Color.resetButtonBackground)
                                .cornerRadius(10)
                                
                                Spacer()
                                // MARK: Ruler switch
                                HStack {
                                    Spacer()
                                    Toggle("",isOn: $simulator.rulerEnabled)
                                        .labelsHidden()
                                    Spacer()
                                    Image(systemName: "ruler.fill")
                                        .resizable()
                                        .foregroundColor(Color.mainButtonBackground)
                                        .font(.largeTitle)
                                        .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.03, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    Spacer()
                                }
                                .frame(width: sideGeo.size.width)
                                .padding(EdgeInsets(top: switchesVerticalPadding, leading: 0, bottom: switchesVerticalPadding, trailing: 0))
                                .background(Color.resetButtonBackground)
                                .cornerRadius(10)

                                
                                Spacer()
                                Button {
                                    // Show calc screen
                                    showCalculations = true
                                    
                                } label: {
                                    ZStack{
                                        Text("Cálculos ⚙️").font(Font.custom("Bangers-Regular", size: geo.size.width * 0.035)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                    }.frame(width: geo.size.width * 0.19, height: geo.size.height * 0.15)
                                    .background(Color(#colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.8, alpha: 1)))
                                    .cornerRadius(10)
                                }
                                .fullScreenCover(isPresented: $showCalculations, content: {
                                    CalculationsView(simulator: $simulator)
                                })
                                Spacer()
                            }
                        }
                        .frame(width: geo.size.width * 0.19, alignment: .center)
                    }
                    .frame(height: geo.size.height / 1.5)
                    GeometryReader { spriteRowGeo in
                        ZStack {
                            Image("green").resizable()
                                .frame(width: geo.size.width)
                            ScrollView(.horizontal) {
                                HStack(alignment: .bottom, spacing: 20) {
                                    ForEach(0..<spritesRow.count) { i in
                                        Button {
                                            if indexSelectedSprite != i {
                                                // User just selected this sprite
                                                simulator.selectedSprite = spritesRow[i]
                                                indexSelectedSprite = i
                                            } else {
                                                // User is toggling this sprite
                                                indexSelectedSprite = nil
                                                simulator.selectedSprite = nil
                                            }
                                        } label: {
                                            VStack(spacing: 0.0) {
                                                Image(uiImage: UIImage(named: spritesRow[i].imageURL)!)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: spriteRowGeo.size.height * 0.9 * getSpriteHeight(sprite: spritesRow[i]))
                                                Text(String(format: (floor(spritesRow[i].weight) == spritesRow[i].weight ? "%.0f" : "%.2f"), spritesRow[i].weight) + " kg")
                                                    .font(Font.custom("Bangers-Regular", size: spriteRowGeo.size.height * 0.10))
                                                    .foregroundColor(.white)
                                            }
                                            .background(Color.red.opacity(indexSelectedSprite == i ? 1.0 : 0.0)) // Background is red if sprite is selected to be placed in simulator
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        //When the view changes
        .onDisappear {
            saveData("SimulatorData.json")
        }
        //When this view appears. Executed AFTER init so var simulator is usable
        .onAppear {
            simulator = loadData("SimulatorData.json")
        }
        //When user exits the app. (Presses home button)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) {
            _ in
            saveData("SimulatorData.json")
        }
    }
    
    //Loads simulator data stored in a JSON file on init
    func loadData(_ filename: String) -> Simulator{
        let data: Data
        
        let fileManager = FileManager.default
        let localPath = getDocumentsDirectory().appendingPathComponent(filename)
        
        //Checking if file exists is DocumentsDirectory
        if fileManager.fileExists(atPath: localPath.path) {
            //The file exists. Load its data into the view
            //print("Si hay json")
            do {
                data = try Data(contentsOf: localPath)
                
                //Initialize simulator with data content
                let decoder = JSONDecoder()
                var s = try decoder.decode(Simulator.self, from: data)
                s.selectedSprite = nil
                return s
            }
            catch {
                print("Error al cargar los datos del archivo")
            }
        }
        else {
            //File does not exist. Load default data in simulator
            //print("No habia json")
            let s = Simulator(quizMode: false)
            return s
        }
        return Simulator(quizMode: false)
    }
    
    //Saves simulator data when current view disappears
    func saveData(_ filename: String) {
        let encoder = JSONEncoder()
        do {
            let localPath = getDocumentsDirectory().appendingPathComponent(filename)
            let encodedData = try encoder.encode(simulator)
            let jsonString = String(data: encodedData, encoding: .utf8)
            try jsonString?.write(to: localPath, atomically: true, encoding: .utf8)
            //print(jsonString!)
        }
        catch {
            print("Error al guardar los datos")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return path
    }
    
    // MARK: - Additional helper functions
    
    func getSpriteHeight(sprite: Sprite) -> CGFloat {
        return CGFloat((sprite.height))
    }
}

struct LabView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            LabView()
        }
    }
}
