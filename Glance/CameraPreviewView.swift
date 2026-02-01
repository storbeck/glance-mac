import AVFoundation
import AppKit

final class CameraPreviewView: NSView {
    private let previewLayer: AVCaptureVideoPreviewLayer
    private let settings = SettingsStore.shared

    init(session: AVCaptureSession) {
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        super.init(frame: .zero)
        wantsLayer = true
        layer = previewLayer
        previewLayer.videoGravity = .resizeAspectFill
        applyMirrorMode()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func layout() {
        super.layout()
        previewLayer.frame = bounds
    }

    func applyMirrorMode() {
        if let connection = previewLayer.connection, connection.isVideoMirroringSupported {
            connection.automaticallyAdjustsVideoMirroring = false
            connection.isVideoMirrored = settings.mirrorMode
        }
    }
}
