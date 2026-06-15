//
//  StickerModal.swift
//  iOSApp2
//
//  Created by Dawit Chernet on 2026-06-05.
//


import SwiftUI

struct StickerModal: View {
    @Binding var stickerImage: UIImage?
    @Environment(\.dismiss) var dismiss
    
    let assetNames = ["Camping/fire", "Camping/tree"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(assetNames, id: \.self) { name in
                        if let uiImage = UIImage(named: name) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .padding()
                                .onTapGesture {
                                    stickerImage = uiImage
                                    dismiss()
                                }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Choose a Sticker")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//PREVIEW BLOCK
#Preview {
    StickerModal(stickerImage: .constant(nil))
}
