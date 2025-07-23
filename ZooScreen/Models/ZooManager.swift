import Foundation

class ZooManager: ObservableObject {
    @Published private(set) var animals: [Animal]
    private var timer: Timer?

    init() {
        animals = Animal.Species.allCases.map { Animal.random(for: $0) }
        startTimer()
    }

    deinit {
        timer?.invalidate()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.updateAnimals()
        }
    }

    private func updateAnimals() {
        for index in animals.indices {
            animals[index].mood = ["Happy", "Playful", "Tired", "Hungry"].randomElement()!
            animals[index].energy = max(0, min(100, animals[index].energy + Int.random(in: -10...10)))
        }
    }
}
