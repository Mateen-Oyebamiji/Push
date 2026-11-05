import SwiftUI

/// Gear toolbar button that opens Settings in a sheet.
struct SettingsButton: View {
    @State private var isShowingSettings = false

    var body: some View {
        Button("Settings", systemImage: "gearshape", action: showSettings)
            .sheet(isPresented: $isShowingSettings) {
                SettingsView()
            }
    }

    private func showSettings() {
        isShowingSettings = true
    }
}
