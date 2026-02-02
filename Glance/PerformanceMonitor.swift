import Foundation
import os
import QuartzCore

final class PerformanceMonitor {
    static let shared = PerformanceMonitor()

    private let log = Logger(subsystem: "dev.pagefoundry.Glance", category: "performance")
    private var launchStart = CACurrentMediaTime()
    private var lastToggleStart: CFTimeInterval?

    private init() {}

    func markLaunchStart() {
        launchStart = CACurrentMediaTime()
    }

    func markLaunchComplete() {
        let elapsed = (CACurrentMediaTime() - launchStart) * 1000
        log.info("App launch time: \(elapsed, privacy: .public) ms")
    }

    func markToggleStart() {
        lastToggleStart = CACurrentMediaTime()
    }

    func markToggleVisible() {
        guard let lastToggleStart else { return }
        let elapsed = (CACurrentMediaTime() - lastToggleStart) * 1000
        log.info("Camera window open time: \(elapsed, privacy: .public) ms")
        self.lastToggleStart = nil
    }
}
