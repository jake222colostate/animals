import Foundation
import SwiftUI

struct Animal: Identifiable {
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

    let id = UUID()
    let species: Species
    var mood: String
    var energy: Int
}

extension Animal {
    static func random(for species: Species) -> Animal {
        Animal(species: species, mood: ["Happy", "Hungry", "Sleepy"].randomElement()!, energy: Int.random(in: 1...100))
    }
}
