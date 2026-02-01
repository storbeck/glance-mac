import AVFoundation
import Combine

final class CameraService: NSObject, ObservableObject {
    enum State: Equatable {
        case idle
        case requestingPermission
        case running
        case unauthorized
        case noDevice
        case inUse
        case error(String)
    }

    @Published var state: State = .idle
    @Published var currentDevice: AVCaptureDevice?
    @Published var availableDevices: [AVCaptureDevice] = []

    let session = AVCaptureSession()

    private var videoInput: AVCaptureDeviceInput?
    private var isConfigured = false
    private let sessionQueue = DispatchQueue(label: "dev.pagefoundry.glance.camera-session")

    override init() {
        super.init()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSessionRuntimeError(_:)),
            name: .AVCaptureSessionRuntimeError,
            object: session
        )
    }

    func start() {
        ensurePermissionAndStart()
    }

    func stop() {
        guard session.isRunning else { return }
        sessionQueue.async {
            self.session.stopRunning()
            DispatchQueue.main.async {
                self.state = .idle
            }
        }
    }

    func retry() {
        start()
    }

    private func ensurePermissionAndStart() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            configureIfNeededAndStart()
        case .notDetermined:
            DispatchQueue.main.async {
                self.state = .requestingPermission
            }
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.configureIfNeededAndStart()
                    } else {
                        self.state = .unauthorized
                    }
                }
            }
        default:
            DispatchQueue.main.async {
                self.state = .unauthorized
            }
        }
    }

    private func configureIfNeededAndStart() {
        if !isConfigured {
            configureSession()
        }

        sessionQueue.async {
            guard !self.session.isRunning else { return }
            self.session.startRunning()
            DispatchQueue.main.async {
                self.state = .running
            }
        }
    }

    private func configureSession() {
        sessionQueue.sync {
            session.beginConfiguration()
            session.sessionPreset = .high

            let devices = discoverDevices()
            let selectedDevice = currentDevice ?? AVCaptureDevice.default(for: .video) ?? devices.first
            if let device = selectedDevice {
                do {
                    let input = try AVCaptureDeviceInput(device: device)
                    if session.canAddInput(input) {
                        session.addInput(input)
                        videoInput = input
                        isConfigured = true
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.state = .error("Failed to access the camera.")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.state = .noDevice
                }
            }

            session.commitConfiguration()

            DispatchQueue.main.async {
                self.availableDevices = devices
                self.currentDevice = selectedDevice
            }
        }
    }

    private func discoverDevices() -> [AVCaptureDevice] {
        let discovery = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera, .externalUnknown],
            mediaType: .video,
            position: .unspecified
        )
        return discovery.devices
    }

    @objc private func handleSessionRuntimeError(_ notification: Notification) {
        guard let error = notification.userInfo?[AVCaptureSessionErrorKey] as? NSError else {
            DispatchQueue.main.async {
                self.state = .error("Camera error.")
            }
            return
        }

        let avError = AVError(_nsError: error)
        DispatchQueue.main.async {
            switch avError.code {
            case .deviceWasDisconnected:
                self.state = .noDevice
            default:
                self.state = .error("Camera error.")
            }
        }
    }
}
