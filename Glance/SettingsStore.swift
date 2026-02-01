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
        static let mirrorMode = "mirrorMode"
        static let selectedCameraID = "selectedCameraID"
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

    var mirrorMode: Bool {
        get {
            if defaults.object(forKey: Keys.mirrorMode) == nil {
                return true
            }
            return defaults.bool(forKey: Keys.mirrorMode)
        }
        set {
            defaults.set(newValue, forKey: Keys.mirrorMode)
        }
    }

    var selectedCameraID: String? {
        get {
            defaults.string(forKey: Keys.selectedCameraID)
        }
        set {
            defaults.set(newValue, forKey: Keys.selectedCameraID)
        }
    }
}
