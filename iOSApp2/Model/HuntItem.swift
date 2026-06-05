//
//  HuntItem.swift
//  iOSApp2
//
//  Created by Dawit Chernet on 2026-06-05.
//

import SwiftUI

/// Represents a single hidden item in the scavenger hunt.
struct HuntItem: Identifiable {
    let id = UUID()
    let clue: String
    let businessName: String // The local business participating
    
    /// The photo the user takes when they find the item. If nil, it hasn't been found.
    var capturedImage: UIImage?
    
    /// A computed property to quickly check if the user has found this specific item.
    var isFound: Bool {
        return capturedImage != nil
    }
}
