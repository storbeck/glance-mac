import AppKit

final class SettingsStore {
    static let shared = SettingsStore()

    private let defaults = UserDefaults.standard

    private init() {
        defaults.register(defaults: [
            Keys.alwaysOnTop: false
        ])
    }

    private enum Keys {
        static let cameraWindowFrame = "cameraWindowFrame"
        static let alwaysOnTop = "alwaysOnTop"
    }

    var cameraWindowFrame: NSRect? {
        get {
            guard let stored = defaults.string(forKey: Keys.cameraWindowFrame) else {
                return nil
            }
            let rect = NSRectFromString(stored)
            return rect.isEmpty ? nil : rect
        }
        set {
            if let newValue {
                defaults.set(NSStringFromRect(newValue), forKey: Keys.cameraWindowFrame)
            } else {
                defaults.removeObject(forKey: Keys.cameraWindowFrame)
            }
        }
    }

    var alwaysOnTop: Bool {
        get {
            defaults.bool(forKey: Keys.alwaysOnTop)
        }
        set {
            defaults.set(newValue, forKey: Keys.alwaysOnTop)
        }
    }
}
