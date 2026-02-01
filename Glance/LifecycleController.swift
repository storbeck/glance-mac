import AppKit

final class LifecycleController {
    static let shared = LifecycleController()

    private init() {}

    func start() {
        let center = NotificationCenter.default
        center.addObserver(
            self,
            selector: #selector(handleWillSleep(_:)),
            name: NSWorkspace.willSleepNotification,
            object: nil
        )
        center.addObserver(
            self,
            selector: #selector(handleDidWake(_:)),
            name: NSWorkspace.didWakeNotification,
            object: nil
        )
        center.addObserver(
            self,
            selector: #selector(handleScreenParametersChanged(_:)),
            name: NSApplication.didChangeScreenParametersNotification,
            object: nil
        )
    }

    @objc private func handleWillSleep(_ notification: Notification) {
        CameraService.shared.stop()
    }

    @objc private func handleDidWake(_ notification: Notification) {
        if CameraWindowController.shared?.isVisible == true {
            CameraService.shared.start()
        }
    }

    @objc private func handleScreenParametersChanged(_ notification: Notification) {
        // Ensure the window remains on-screen and the session stays valid.
        if CameraWindowController.shared?.isVisible == true {
            CameraService.shared.start()
        }
    }
}
