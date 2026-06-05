import SwiftUI

struct ResizableView: ViewModifier {
    @State private var transform = Transform()
    @State private var previousOffset: CGSize = .zero
    @State private var previousRotation: Angle = .zero
    @State private var scale: CGFloat = 1.0
    
    func body(content: Content) -> some View {
        content
            .frame(width: transform.size.width, height: transform.size.height)
            .rotationEffect(transform.rotation)
            .offset(transform.offset)
            .gesture(dragGesture)
            .gesture(SimultaneousGesture(rotationGesture, scaleGesture))
            .scaleEffect(scale)
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in transform.offset = value.translation + previousOffset }
            .onEnded { _ in previousOffset = transform.offset }
    }
    
    var rotationGesture: some Gesture {
        RotationGesture()
            .onChanged { rotation in transform.rotation = rotation + previousRotation }
            .onEnded { _ in previousRotation = transform.rotation }
    }
    
    var scaleGesture: some Gesture {
        MagnificationGesture()
            .onChanged { scale in self.scale = scale }
            .onEnded { scale in
                transform.size = transform.size * scale
                self.scale = 1.0
            }
    }
}

extension View {
    func resizableView() -> some View { modifier(ResizableView()) }
}