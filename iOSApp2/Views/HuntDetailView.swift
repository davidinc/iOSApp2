//
//  Untitled.swift
//  iOSApp2
//
//  Created by Dawit Chernet on 2026-06-05.
//

import SwiftUI
import CoreLocation

struct HuntDetailView: View {
    @Bindable var item: HuntItem
    @StateObject private var locationManager = LocationManager()
    
    @State private var showingCamera = false
    @State private var showingStickerModal = false
    @State private var selectedSticker: UIImage?
    @State private var liveImage: UIImage?
    
    // Calculates if the user is within 50 meters of the target
    var isNearTarget: Bool {
            #if targetEnvironment(simulator)
            return true // 👈 CHEAT CODE: Always unlock on the simulator
            #else
            guard let userLoc = locationManager.userLocation else { return false }
            let targetLoc = CLLocation(latitude: item.targetLatitude, longitude: item.targetLongitude)
            return userLoc.distance(from: targetLoc) < 50
            #endif
        }
    
    // Extracted the canvas into its own variable so we can flatten it later
    var canvasView: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            
            if let data = item.photoData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage).resizable().scaledToFit().shadow(radius: 5)
                
                ForEach(item.elements) { element in
                    if let stickerImg = UIImage(data: element.imageData) {
                        Image(uiImage: stickerImg).resizable().scaledToFit()
                            .frame(width: 150, height: 150).resizableView()
                    }
                }
            } else {
                VStack {
                    Image(systemName: isNearTarget ? "lock.open" : "lock.fill").font(.system(size: 50))
                    Text(isNearTarget ? "You're here! Tap Camera to unlock." : "Get within 50m of the business to unlock.")
                        .multilineTextAlignment(.center).padding()
                }.foregroundColor(.gray)
            }
        }.clipped()
    }
    
    var body: some View {
        VStack {
            Text(item.businessName).font(.largeTitle).bold()
            Text(item.clue).font(.title3).foregroundColor(.secondary).padding(.bottom).multilineTextAlignment(.center)
            
            canvasView
            
            HStack {
                Button(action: { showingCamera = true }) {
                    Label(item.isFound ? "Retake" : "Camera", systemImage: "camera")
                }.buttonStyle(.borderedProminent).disabled(!isNearTarget)
                
                Spacer()
                
                if item.isFound {
                    Button(action: { showingStickerModal = true }) {
                        Label("Stickers", systemImage: "heart.circle")
                    }.buttonStyle(.borderedProminent).tint(.orange)
                }
            }.padding()
        }
        .toolbar {
            if item.isFound {
                ToolbarItem(placement: .topBarTrailing) {
                    ShareLink(item: renderCanvas(), preview: SharePreview("Hunt Photo", image: renderCanvas())) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                }
            }
        }
        .sheet(isPresented: $showingCamera) { LiveCameraView(image: $liveImage) }
        .sheet(isPresented: $showingStickerModal) { StickerModal(stickerImage: $selectedSticker) }
        .onChange(of: liveImage) { newImage in
            if let img = newImage, let data = img.jpegData(compressionQuality: 0.8) { item.photoData = data }
        }
        .onChange(of: selectedSticker) { newSticker in
            if let img = newSticker, let data = img.pngData() {
                item.elements.append(HuntElement(imageData: data))
                selectedSticker = nil
            }
        }
    }
    
    // Uses ImageRenderer to flatten the ZStack into a single exportable image
    @MainActor func renderCanvas() -> Image {
        let renderer = ImageRenderer(content: canvasView.frame(width: 800, height: 800))
        if let uiImage = renderer.uiImage {
            return Image(uiImage: uiImage)
        }
        return Image(systemName: "photo")
    }
}
