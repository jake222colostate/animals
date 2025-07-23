import SwiftUI

struct SettingsView: View {
    @AppStorage("evolutionInterval") private var interval: Double = 5

    var body: some View {
        Form {
            Section("Evolution") {
                Stepper(value: $interval, in: 1...60, step: 1) {
                    Text("Update every \(Int(interval))s")
                }
            }
            Section("About") {
                Text("ZooScreen Demo")
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
