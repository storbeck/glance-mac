import SwiftUI

struct CameraWindowView: View {
    var body: some View {
        ZStack {
            Color.black
            Text("Camera Preview")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.7))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CameraWindowView()
        .frame(width: 480, height: 320)
}
