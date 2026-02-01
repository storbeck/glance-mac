import AppKit
import SwiftUI

final class CameraWindowController: NSObject, NSWindowDelegate {
    private let panel: NSPanel
    private var didSetInitialPosition = false
    private let settings = SettingsStore.shared

    override init() {
        let contentView = CameraWindowView()
        let hostingView = NSHostingView(rootView: contentView)

        panel = NSPanel(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 320),
            styleMask: [.borderless, .resizable],
            backing: .buffered,
            defer: false
        )
        super.init()

        panel.contentView = hostingView
        panel.isReleasedWhenClosed = false
        panel.isMovableByWindowBackground = true
        panel.hasShadow = true
        panel.backgroundColor = NSColor.black
        panel.hidesOnDeactivate = false
        panel.titleVisibility = .hidden
        panel.titlebarAppearsTransparent = true
        panel.standardWindowButton(.closeButton)?.isHidden = true
        panel.standardWindowButton(.miniaturizeButton)?.isHidden = true
        panel.standardWindowButton(.zoomButton)?.isHidden = true
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        panel.delegate = self

        applyAlwaysOnTop()

        if let savedFrame = settings.cameraWindowFrame {
            panel.setFrame(savedFrame, display: false)
            didSetInitialPosition = true
        }
    }

    var isVisible: Bool {
        panel.isVisible
    }

    func toggle() -> Bool {
        if panel.isVisible {
            panel.orderOut(nil)
            return false
        } else {
            if !didSetInitialPosition {
                panel.center()
                didSetInitialPosition = true
            }
            applyAlwaysOnTop()
            panel.orderFrontRegardless()
            panel.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return true
        }
    }

    func windowWillClose(_ notification: Notification) {
        panel.orderOut(nil)
    }

    func windowDidMove(_ notification: Notification) {
        saveFrame()
    }

    func windowDidResize(_ notification: Notification) {
        saveFrame()
    }

    func applyAlwaysOnTop() {
        panel.level = settings.alwaysOnTop ? .floating : .normal
    }

    private func saveFrame() {
        settings.cameraWindowFrame = panel.frame
    }
}
