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
    static var mainTextForeground = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    static var resetTextForeground = Color.red
    
    // MARK: Buttons
    static var mainButtonTextForeground = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    static var mainButtonBackground = Color(#colorLiteral(red: 1, green: 0.6, blue: 0.07843137255, alpha: 1))
    
    static var secondaryButtonBackground = Color.init(Color.RGBColorSpace.sRGB, red: 59/255, green: 40/255, blue: 204/255, opacity: 1.0)
    
    // MARK: Titles
    static var mainTitleTextForeground = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    static var mainTitleBackground = Color(#colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.8, alpha: 1))
    static var mainTitleBackgroundBorder = Color(#colorLiteral(red: 0.7184793949, green: 0.7786805034, blue: 0.8376973271, alpha: 1))
    
    
    // MARK: - Select Level
    static var selectLevelButtonBackground = Color(#colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.8, alpha: 1))
    
    // MARK: - Calculations View
    static var calculationsBackground = Color(#colorLiteral(red: 0.9647058824, green: 0.8941176471, blue: 0.8274509804, alpha: 1))
    
    // MARK: - Quiz
    static var resetButtonBackground = Color(#colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.8, alpha: 1))
    
    static var quizTextForeground = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    static var quizSelectedSpriteWeightTextForeground = Color(#colorLiteral(red: 0.9215686275, green: 0.1647058824, blue: 0.1647058824, alpha: 1))
    
    // MARK: - Quiz Feedback Alerts
    static var alertButtonBackground = Color.white
    
    static var correctAlertBackground = Color.init(Color.RGBColorSpace.sRGB, red: 50/255, green: 168/255, blue: 82/255, opacity: 1.0)
    
    static var wrongAlertBackground = Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 111/255, blue: 111/255, opacity: 1.0)
    
    static var wrongAlertTitleBackground = Color.init(Color.RGBColorSpace.sRGB, red: 255/255, green: 153/255, blue: 20/255, opacity: 1.0)
    static var correctAlertTitleBackground = Color.white
    
    // MARK: - Quiz Help
    static var quizHelpBackground = Color(#colorLiteral(red: 0.9647058824, green: 0.8941176471, blue: 0.8274509804, alpha: 1))
    
    // MARK: - Miscellaneous
    static var rulerFill = Color.orange
    
    static var selectedSpriteTextForeground = Color.orange
    
    static var whiteBackground = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    static var secundaryBackground = Color(#colorLiteral(red: 0.6784313725, green: 0.4784313725, blue: 0.2117647059, alpha: 1))
    static var pointsBackground = Color(#colorLiteral(red: 0.1058823529, green: 0.7019607843, blue: 0.1725490196, alpha: 1))
}
