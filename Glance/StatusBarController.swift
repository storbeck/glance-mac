import AppKit

final class StatusBarController: NSObject {
    private let statusItem: NSStatusItem
    private let menu: NSMenu
    private let cameraWindowController = CameraWindowController()
    private let preferencesWindowController = PreferencesWindowController()
    private var isCameraActive = false {
        didSet {
            updateIcon()
        }
    }

    override init() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        menu = NSMenu()
        super.init()
        configureMenu()
        configureButton()
        updateIcon()
    }

    private func configureMenu() {
        let preferencesItem = NSMenuItem(
            title: "Preferences...",
            action: #selector(openPreferences),
            keyEquivalent: ","
        )
        preferencesItem.target = self

        let quitItem = NSMenuItem(
            title: "Quit",
            action: #selector(quit),
            keyEquivalent: "q"
        )
        quitItem.target = self

        menu.addItem(preferencesItem)
        menu.addItem(.separator())
        menu.addItem(quitItem)
    }

    private func configureButton() {
        guard let button = statusItem.button else { return }
        button.imagePosition = .imageOnly
        button.target = self
        button.action = #selector(statusItemClicked)
        button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        button.toolTip = "Glance"
    }

    @objc private func statusItemClicked() {
        guard let event = NSApp.currentEvent else {
            return
        }

        switch event.type {
        case .rightMouseUp:
            showMenu()
        default:
            toggleCameraWindow()
        }
    }

    private func showMenu() {
        statusItem.menu = menu
        statusItem.button?.performClick(nil)
        statusItem.menu = nil
    }

    private func toggleCameraWindow() {
        PerformanceMonitor.shared.markToggleStart()
        isCameraActive = cameraWindowController.toggle()
        if isCameraActive {
            PerformanceMonitor.shared.markToggleVisible()
        }
    }

    private func updateIcon() {
        let symbolName = isCameraActive ? "camera.fill" : "camera"
        let configuration = NSImage.SymbolConfiguration(pointSize: 13, weight: .regular)
        guard let image = NSImage(systemSymbolName: symbolName, accessibilityDescription: nil)?
            .withSymbolConfiguration(configuration) else {
            return
        }
        image.isTemplate = true
        statusItem.button?.image = image
    }

    @objc private func openPreferences() {
        preferencesWindowController.show()
    }

    @objc private func quit() {
        NSApp.terminate(nil)
    }
}
