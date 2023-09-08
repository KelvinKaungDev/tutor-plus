import SwiftUI

@main
struct API_CRUDApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TutorViewModel())
        }
    }
}
