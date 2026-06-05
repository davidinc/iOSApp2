import SwiftUI

struct StickerModal: View {
    @Binding var stickerImage: UIImage?
    @Environment(\.dismiss) var dismiss
    
    // Exact names of the files you dragged into Assets.xcassets
    let assetNames = ["fire", "tree"] 
    
    var body: some View {
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
    }
}