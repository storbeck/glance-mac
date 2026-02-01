import SwiftUI

struct CameraWindowView: View {
    @ObservedObject var cameraService: CameraService

    var body: some View {
        ZStack {
            CameraPreviewRepresentable(cameraService: cameraService)
            statusOverlay
        }
        .ignoresSafeArea()
    }

    @ViewBuilder
    private var statusOverlay: some View {
        switch cameraService.state {
        case .running:
            EmptyView()
        case .requestingPermission:
            overlayView(
                title: "Requesting Camera Access",
                message: "Please allow camera access to show the preview.",
                showRetry: false
            )
        case .unauthorized:
            overlayView(
                title: "Camera Access Denied",
                message: "Enable camera access in System Settings > Privacy & Security > Camera.",
                showRetry: true
            )
        case .noDevice:
            overlayView(
                title: "No Camera Found",
                message: "Connect a camera and try again.",
                showRetry: true
            )
        case .error(let message):
            overlayView(
                title: "Camera Error",
                message: message,
                showRetry: true
            )
        case .idle:
            overlayView(
                title: "Camera Stopped",
                message: "Click Retry to start the camera.",
                showRetry: true
            )
        }
    }

    private func overlayView(title: String, message: String, showRetry: Bool) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
            Text(message)
                .font(.system(size: 12))
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.8))
            if showRetry {
                Button("Retry") {
                    cameraService.retry()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding(16)
        .background(Color.black.opacity(0.6))
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    CameraWindowView(cameraService: CameraService())
        .frame(width: 480, height: 320)
}
