import SwiftUI

struct AnimalView: View {
    var animal: Animal

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
    }
}

#Preview {
    AnimalView(animal: .random(for: .monkey))
}
