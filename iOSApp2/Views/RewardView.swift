//
//  RewardView.swift
//  iOSApp2
//
//  Created by Dawit Chernet on 2026-06-05.
//
import SwiftUI

struct RewardView: View {
    // 1. This variable allows RewardView to accept the argument from HuntListView
    var totalFound: Int
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Hunt Results")
                .font(.largeTitle)
                .bold()
                .padding(.top, 40)
            
            Text("You found \(totalFound) items!")
                .font(.title2)
            
            VStack(spacing: 15) {
                // 2. Logic updated to use the passed variable
                if totalFound >= 5 { // Adjust these thresholds based on your total items
                    RewardCard(title: "Ultimate Scavenger!", description: "20% Discount: CHAMBER20\nEntered for $5,000 Grand Prize!", color: .purple)
                } else if totalFound >= 3 {
                    RewardCard(title: "Great Job!", description: "10% Discount: LOCAL10", color: .blue)
                } else {
                    RewardCard(title: "Keep Going!", description: "Find at least 3 items to unlock a discount.", color: .orange)
                }
            }
            .padding()
            
            Spacer()
            
            Button("Done") { dismiss() }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
            .padding()
        }
    }
}

// Helper view for the cards
struct RewardCard: View {
    var title: String
    var description: String
    var color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title).font(.title).bold().foregroundColor(color)
            Text(description).font(.body).multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(color.opacity(0.1))
        .cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(color, lineWidth: 2))
    }
}

// 3. Update the preview to pass a dummy argument so the canvas works
#Preview {
    RewardView(totalFound: 5)
}
