import SwiftUI

struct HomeView: View {
    @StateObject private var zooManager = ZooManager()

    var body: some View {
        NavigationStack {
            List($zooManager.animals) { $animal in
                AnimalView(animal: $animal, zooManager: zooManager)
            }
            .navigationTitle("Zoo Screen")
            .toolbar {
                NavigationLink("Settings") {
                    SettingsView()
                }
            }
        }
        .task {
            ZooActivityController.shared.start(with: zooManager.animals)
        }
    }
}

#Preview {
    HomeView()
}
