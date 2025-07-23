import Foundation

class ZooManager: ObservableObject {
    @Published private(set) var animals: [Animal]
    private var timer: Timer?
    private let saveKey = "ZooManager.animals"
    private let dateKey = "ZooManager.lastDate"

    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let saved = try? JSONDecoder().decode([Animal].self, from: data) {
            animals = saved
        } else {
            animals = Animal.Species.allCases.map { Animal.random(for: $0) }
        }

        let lastDate = UserDefaults.standard.object(forKey: dateKey) as? Date ?? Date()
        advanceTime(by: Date().timeIntervalSince(lastDate))
        startTimer()
    }

    deinit {
        timer?.invalidate()
    }

    func startTimer() {
        let interval = UserDefaults.standard.double(forKey: "evolutionInterval")
        let time = interval > 0 ? interval : 5
        timer = Timer.scheduledTimer(withTimeInterval: time, repeats: true) { [weak self] _ in
            self?.updateAnimals()
        }
    }

    private func updateAnimals() {
        for index in animals.indices {
            animals[index].mood = ["Happy", "Playful", "Tired", "Hungry"].randomElement()!
            animals[index].energy = max(0, min(100, animals[index].energy + Int.random(in: -10...10)))
            animals[index].age += 5
        }
        save()
    }

    private func advanceTime(by interval: TimeInterval) {
        guard interval > 0 else { return }
        for index in animals.indices {
            animals[index].age += interval
            let drop = Int(interval / 60)
            animals[index].energy = max(0, animals[index].energy - drop)
        }
    }

    func perform(_ action: AnimalAction, on animalID: UUID) {
        guard let index = animals.firstIndex(where: { $0.id == animalID }) else { return }
        animals[index].perform(action)
        save()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(animals) {
            UserDefaults.standard.set(data, forKey: saveKey)
            UserDefaults.standard.set(Date(), forKey: dateKey)
        }
    }
}
