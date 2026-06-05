//
//  HuntStore.swift
//  iOSApp2
//
//  Created by Dawit Chernet on 2026-06-05.
//

import SwiftUI
import Combine   // <-- Explicitly!

/// Manages the state of the scavenger hunt, holding the items and calculating rewards.
class HuntStore: ObservableObject {
    @Published var items: [HuntItem] = [
        HuntItem(clue: "Find the oldest book in the window display.", businessName: "Main St. Books"),
        HuntItem(clue: "Take a picture of the giant popcorn bucket.", businessName: "Starlight Cinema"),
        HuntItem(clue: "Locate the secret menu sign by the register.", businessName: "Joe's Diner"),
        HuntItem(clue: "Find the blue guitar signed by a local legend.", businessName: "Harmony Music"),
        HuntItem(clue: "Spot the wooden bear carving near the entrance.", businessName: "Lumberjack Coffee"),
        HuntItem(clue: "Find the vintage 1980s arcade cabinet.", businessName: "Pixel Arcade"),
        HuntItem(clue: "Take a photo of the largest pizza slice display.", businessName: "Tony's Pizzeria"),
        HuntItem(clue: "Locate the golden running shoe.", businessName: "Velocity Sports"),
        HuntItem(clue: "Find the hidden gnome in the greenhouse.", businessName: "City Bloom Nursery"),
        HuntItem(clue: "Take a picture of the neon 'Open' sign.", businessName: "Midnight Bakery")
    ]
    
    /// Calculates the total number of items the user has successfully photographed.
    var totalFound: Int {
        items.filter { $0.isFound }.count
    }
}
