import SwiftUI

struct TabBarView: View {
    @StateObject var dataManager = DataManager()
    
    var body: some View {
        VStack {
            
            TabView {
                StatisticsMenuView(dataManager: dataManager)
                    .tabItem {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                
                TrainingRouterView(dataManager: dataManager)
                    .tabItem {
                        Image(systemName: "figure.strengthtraining.traditional")
                    }
            }
        }
        
    }
}
