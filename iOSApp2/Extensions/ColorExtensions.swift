//
//  ColorExtensions.swift
//  iOSApp2
//
//  Created by Dawit Chernet on 2026-06-05.
//


import SwiftUI

extension Color {
    static let cardColors: [Color] = [
        .red, .blue, .green, .yellow, .orange, .purple, .pink, .teal, .mint
    ]
    
    static func random() -> Color {
        cardColors.randomElement() ?? .black
    }
}
