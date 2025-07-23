import ActivityKit
import SwiftUI

struct MonkeyActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var action: String
        var progress: Double
    }
}

struct MonkeyLiveActivityView: View {
    let context: ActivityViewContext<MonkeyActivityAttributes>

    var body: some View {
        VStack {
            Text("🐵 \\(context.state.action)")
            ProgressView(value: context.state.progress)
        }
        .padding()
    }
}
