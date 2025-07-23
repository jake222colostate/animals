import SwiftUI

struct AnimalView: View {
    @Binding var animal: Animal
    var zooManager: ZooManager

    var body: some View {
        HStack {
            Text(animal.species.icon)
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text(animal.species.rawValue.capitalized)
                    .font(.headline)
                Text("Mood: \(animal.mood)")
                Text("Energy: \(animal.energy)")
            }
            Spacer()
        }
        .padding()
        .contextMenu {
            Button("Feed") { zooManager.perform(.feed, on: animal.id) }
            Button("Play") { zooManager.perform(.play, on: animal.id) }
            Button("Rest") { zooManager.perform(.rest, on: animal.id) }
        }
    }
}

#Preview {
    @State static var a = Animal.random(for: .monkey)
    return AnimalView(animal: $a, zooManager: ZooManager())
}
