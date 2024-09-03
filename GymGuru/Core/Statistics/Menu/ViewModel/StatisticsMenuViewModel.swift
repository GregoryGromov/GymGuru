import Foundation
import Combine


class StatisticsMenuViewModel: ObservableObject {
    let dataManager: DataManager
    private var cancellables = Set<AnyCancellable>()
    
    @Published var trainings: [Training] = []
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        dataManager.$trainings
            .map { Array($0.values) }  // Преобразование Dictionary в массив значений
            .receive(on: RunLoop.main)
            .assign(to: \.trainings, on: self)
            .store(in: &cancellables)
    }
}

