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
    let spritesRow = [
        Sprite(name: "Mario", weight: 20, height: 1, imageURL: "mario"),
        Sprite(name: "Kirby", weight: 10, height: 1, imageURL: "kirby"),
        Sprite(name: "Steve", weight: 30, height: 1, imageURL: "steve"),
        Sprite(name: "Master Chief", weight: 80, height: 1, imageURL: "masterchief"),
        Sprite(name: "Plankton", weight: 5, height: 1, imageURL: "plankton"),
        Sprite(name: "Sonic", weight: 15, height: 1, imageURL: "sonic"),
        Sprite(name: "Link", weight: 60, height: 1, imageURL: "link"),
        Sprite(name: "Megaman", weight: 20, height: 1, imageURL: "megaman")
    ]
    
    // Data structure to store placed characters
    @State var simulator: Simulator = Simulator()
    
    @State var indexSelectedSprite: Int? = nil
    
    var body: some View {
        ZStack {
            // Aquí va el fondo del juego
            Image("Background2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geo in
                VStack {
                    HStack(spacing: 0.0) {
                        SimulatorView(simulator: $simulator)
                            .frame(width: geo.size.width * 0.8)
                        
                        GeometryReader { sideGeo in
                            let switchesVerticalPadding: CGFloat = sideGeo.size.height * 0.03
                            VStack {
                                Spacer()
                                HStack {
                                    // Buttons
                                    Spacer()
                                    Button {
                                        // Return to home
                                        presentationMode.wrappedValue.dismiss()
                                    } label: {
                                        Image(systemName: "house.fill")
                                            .foregroundColor(.black)
                                            .font(.largeTitle)
                                    }
                                    Spacer()
                                    Button {
                                        // Reset simulator
                                        simulator.reset()
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(Color.red)
                                            .font(.largeTitle)
                                    }
                                    Spacer()
                                }
                                Spacer()
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
                                .frame(width: sideGeo.size.width, height: sideGeo.size.height * 0.1)
                                .padding(EdgeInsets(top: switchesVerticalPadding, leading: 0, bottom: switchesVerticalPadding, trailing: 0))
                                .background(Color.init(Color.RGBColorSpace.sRGB, red: 59/255, green: 40/255, blue: 204/255, opacity: 1.0))
                                
                                Spacer()
                                HStack {
                                    Spacer()
                                    Toggle("",isOn: $simulator.rulerEnabled)
                                        .labelsHidden()
                                    Spacer()
                                    Image(systemName: "ruler.fill")
                                        .foregroundColor(Color.orange)
                                        .font(.largeTitle)
                                    Spacer()
                                }
                                .frame(width: sideGeo.size.width)
                                .padding(EdgeInsets(top: switchesVerticalPadding, leading: 0, bottom: switchesVerticalPadding, trailing: 0))
                                .background(Color.init(Color.RGBColorSpace.sRGB, red: 59/255, green: 40/255, blue: 204/255, opacity: 1.0))
                                
                                Spacer()
                                Button {
                                    // Show calc screen
                                    showCalculations = true
                                    
                                } label: {
                                    Text("Ver cálculos ⚙️")
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
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
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
                                    VStack {
                                        Image(uiImage: UIImage(named: spritesRow[i].imageURL)!)
                                            .resizable()
                                            .scaledToFit()
                                        Text(String(spritesRow[i].weight) + " kg")
                                    }
                                    .background(Color.red.opacity(indexSelectedSprite == i ? 1.0 : 0.0)) // Background is red if sprite is selected to be placed in simulator
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
                let s = try decoder.decode(Simulator.self, from: data)
                return s
            }
            catch {
                print("Error al cargar los datos del archivo")
            }
        }
        else {
            //File does not exist. Load default data in simulator
            //print("No habia json")
            let s = Simulator()
            return s
        }
        return Simulator()
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
}

struct LabView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            LabView()
        }
    }
}
