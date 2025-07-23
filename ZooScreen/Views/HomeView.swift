import SwiftUI

struct HomeView: View {
    @StateObject private var zooManager = ZooManager()

    var body: some View {
        NavigationStack {
            List(zooManager.animals) { animal in
                AnimalView(animal: animal)
            }
            .navigationTitle("Zoo Screen")
        }
        .task {
            MonkeyActivityController.shared.start()
        }
    }
}

#Preview {
    HomeView()
}
