import AVFoundation
import SwiftUI

struct PreferencesView: View {
    @ObservedObject private var cameraService = CameraService.shared
    @StateObject private var launchAtLogin = LaunchAtLoginManager()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Toggle("Launch at login", isOn: Binding(
                get: { launchAtLogin.isEnabled },
                set: { launchAtLogin.setEnabled($0) }
            ))

            Toggle("Mirror video", isOn: Binding(
                get: { SettingsStore.shared.mirrorMode },
                set: { SettingsStore.shared.mirrorMode = $0 }
            ))

            HStack {
                Text("Camera")
                Spacer()
                Picker("Camera", selection: Binding(
                    get: { cameraService.currentDevice?.uniqueID ?? "" },
                    set: { newValue in
                        if let device = cameraService.availableDevices.first(where: { $0.uniqueID == newValue }) {
                            cameraService.selectDevice(device)
                        }
                    }
                )) {
                    ForEach(cameraService.availableDevices, id: \.uniqueID) { device in
                        Text(device.localizedName).tag(device.uniqueID)
                    }
                }
                .labelsHidden()
                .frame(width: 220)
            }

            if let message = launchAtLogin.lastErrorMessage {
                Text(message)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(20)
        .frame(width: 360)
    }
}

#Preview {
    PreferencesView()
}
