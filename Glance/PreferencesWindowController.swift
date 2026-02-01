import AppKit
import SwiftUI

final class PreferencesWindowController: NSObject, NSWindowDelegate {
    private let window: NSWindow

    override init() {
        let hostingView = NSHostingView(rootView: PreferencesView())
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 360, height: 240),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        super.init()

        window.title = "Preferences"
        window.isReleasedWhenClosed = false
        window.contentView = hostingView
        window.center()
        window.delegate = self
    }

    func show() {
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}
