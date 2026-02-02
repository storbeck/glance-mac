import AppKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusBarController: StatusBarController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        PerformanceMonitor.shared.markLaunchStart()
        statusBarController = StatusBarController()
        LifecycleController.shared.start()
        PerformanceMonitor.shared.markLaunchComplete()
    }
}
