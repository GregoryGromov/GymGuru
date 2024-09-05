import SwiftUI

struct TabBarView: View {
    let dataManager = DataManager()
    let exerciseManager = ExerciseManager()
    
    var body: some View {
        VStack {
            TabView {
                StatisticsMenuView(
                    dataManager: dataManager,
                    exerciseManager: exerciseManager
                )
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
                
                TrainingRouterView(
                    dataManager: dataManager,
                    exerciseManager: exerciseManager
                )
                .tabItem {
                    Image(systemName: "figure.strengthtraining.traditional")
                }
            }
        }
    }
}
