import AVFoundation
import SwiftUI

struct CameraWindowView: View {
    @ObservedObject var cameraService: CameraService
    @State private var isHovering = false

    var body: some View {
        ZStack {
            CameraPreviewRepresentable(cameraService: cameraService)
            statusOverlay
        }
        .ignoresSafeArea()
        .overlay(alignment: .bottomTrailing) {
            if isHovering {
                Button(cameraServiceMirrorTitle) {
                    cameraService.toggleMirror()
                }
                .buttonStyle(.borderless)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
                .padding(8)
                .background(Color.black.opacity(0.4))
                .cornerRadius(8)
                .padding(8)
                .transition(.opacity)
            }
        }
        .overlay(alignment: .bottomLeading) {
            if isHovering {
                cameraMenu
                    .padding(8)
                    .transition(.opacity)
            }
        }
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.15)) {
                isHovering = hovering
            }
        }
    }

    private var cameraServiceMirrorTitle: String {
        SettingsStore.shared.mirrorMode ? "Mirrored" : "Normal"
    }

    private var cameraMenu: some View {
        Menu {
            ForEach(cameraService.availableDevices, id: \.uniqueID) { device in
                Button(device.localizedName) {
                    cameraService.selectDevice(device)
                }
            }
        } label: {
            Text(cameraService.currentDevice?.localizedName ?? "Camera")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
                .padding(8)
                .background(Color.black.opacity(0.4))
                .cornerRadius(8)
        }
        .menuStyle(.borderlessButton)
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
        default:
            EmptyView()
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
    CameraWindowView(cameraService: CameraService.shared)
        .frame(width: 480, height: 320)
}
