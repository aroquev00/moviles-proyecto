//
//  ColorExtension.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 16/05/21.
//

import SwiftUI

extension Color {
    
    // MARK: - General
    
    // MARK: Text
    static var mainTextForeground = Color.black
    static var resetTextForeground = Color.red
    
    // MARK: Buttons
    static var mainButtonTextForeground = Color.white
    static var mainButtonBackground = Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 153/255, blue: 20/255, opacity: 1.0)
    
    static var secondaryButtonBackground = Color.init(Color.RGBColorSpace.sRGB, red: 59/255, green: 40/255, blue: 204/255, opacity: 1.0)
    
    // MARK: Titles
    static var mainTitleTextForeground = Color.white
    static var mainTitleBackground = Color(#colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.8, alpha: 1))
    static var mainTitleBackgroundBorder = Color.init(Color.RGBColorSpace.sRGB, red: 169/255, green: 186/255, blue: 204/255, opacity: 1.0)
    
    
    // MARK: - Select Level
    static var selectLevelButtonBackground = Color(#colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.8, alpha: 1))
    
    // MARK: - Quiz Feedback Alerts
    static var alertButtonBackground = Color.white
    
    static var correctAlertBackground = Color.init(Color.RGBColorSpace.sRGB, red: 50/255, green: 168/255, blue: 82/255, opacity: 1.0)
    
    static var wrongAlertBackground = Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 111/255, blue: 111/255, opacity: 1.0)
    
    static var wrongAlertTitleBackground = Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 153/255, blue: 20/255, opacity: 1.0)
    static var correctAlertTitleBackground = Color.white
    
    // MARK: - Miscellaneous
    static var rulerFill = Color.orange
    
    static var selectedSpriteTextForeground = Color.orange
}
