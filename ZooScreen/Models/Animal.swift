import Foundation
import SwiftUI

struct Animal: Identifiable, Codable {
    enum Species: String, CaseIterable {
        case monkey
        case dog
        case cat
        case turtle
        case bird

        var icon: String {
            switch self {
            case .monkey: return "🐵"
            case .dog: return "🐶"
            case .cat: return "🐱"
            case .turtle: return "🐢"
            case .bird: return "🐦"
            }
        }
    }

    let id: UUID
    let species: Species
    var mood: String
    var energy: Int
    var age: TimeInterval

    init(id: UUID = UUID(), species: Species, mood: String, energy: Int, age: TimeInterval = 0) {
        self.id = id
        self.species = species
        self.mood = mood
        self.energy = energy
        self.age = age
    }
}

extension Animal {
    static func random(for species: Species) -> Animal {
        Animal(species: species, mood: ["Happy", "Hungry", "Sleepy"].randomElement()!, energy: Int.random(in: 1...100))
    }
}

enum AnimalAction {
    case feed
    case play
    case rest
}

extension Animal {
    mutating func perform(_ action: AnimalAction) {
        switch action {
        case .feed:
            mood = "Full"
            energy = min(100, energy + 20)
        case .play:
            mood = "Happy"
            energy = max(0, energy - 20)
        case .rest:
            mood = "Resting"
            energy = min(100, energy + 10)
        }
    }
}
