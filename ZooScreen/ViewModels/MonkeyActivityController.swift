import ActivityKit
import Foundation

class MonkeyActivityController {
    static let shared = MonkeyActivityController()
    private init() {}

    private var activity: Activity<MonkeyActivityAttributes>?

    func start() {
        let attributes = MonkeyActivityAttributes()
        let state = MonkeyActivityAttributes.ContentState(action: "swinging", progress: 0.1)
        activity = try? Activity.request(attributes: attributes, contentState: state, pushType: nil)
    }

    func update(action: String, progress: Double) async {
        guard let activity else { return }
        let state = MonkeyActivityAttributes.ContentState(action: action, progress: progress)
        await activity.update(ActivityContent(state: state, staleDate: nil))
    }
}
