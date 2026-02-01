import SwiftUI

struct CameraPreviewRepresentable: NSViewRepresentable {
    @ObservedObject var cameraService: CameraService

    func makeNSView(context: Context) -> CameraPreviewView {
        CameraPreviewView(session: cameraService.session)
    }

    func updateNSView(_ nsView: CameraPreviewView, context: Context) {
        nsView.applyMirrorMode()
    }
}
