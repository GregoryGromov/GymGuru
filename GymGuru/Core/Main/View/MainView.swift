import SwiftUI

struct MainView: View {
    @StateObject var dataManager = DataManager()
    
    var body: some View {
        VStack {

            
            TabView {
                Text("Статистика")
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
