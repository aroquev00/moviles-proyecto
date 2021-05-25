//
//  moviles_proyectoApp.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 19/03/21.
//

import SwiftUI

@main
struct moviles_proyectoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MainMenuView()
        }
    }
}

