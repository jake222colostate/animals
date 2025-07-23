import ActivityKit
import Foundation

class ZooActivityController {
    static let shared = ZooActivityController()
    private init() {}

    private var activity: Activity<ZooActivityAttributes>?

    func start(with animals: [Animal]) {
        let infos = animals.prefix(3).map { ZooActivityAttributes.AnimalInfo(icon: $0.species.icon, action: $0.mood.lowercased()) }
        let attributes = ZooActivityAttributes()
        let state = ZooActivityAttributes.ContentState(animals: infos)
        activity = try? Activity.request(attributes: attributes, contentState: state, pushType: nil)
    }

    func update(with animals: [Animal]) async {
        guard let activity else { return }
        let infos = animals.prefix(3).map { ZooActivityAttributes.AnimalInfo(icon: $0.species.icon, action: $0.mood.lowercased()) }
        let state = ZooActivityAttributes.ContentState(animals: infos)
        await activity.update(ActivityContent(state: state, staleDate: nil))
    }
}
