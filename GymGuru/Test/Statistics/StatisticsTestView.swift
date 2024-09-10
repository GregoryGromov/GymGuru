import SwiftUI
import Charts

enum ChartTimePeriod: Int, CaseIterable {
    case week1 = 604800
    case week2 = 1209600
    case month1 = 2592000
    case month3 = 7776000
    case month6 = 15552000
    case year1 = 31104000
}

struct StatisticsTestView: View {
    
    // ОСТАНОВКА:  Нужно сделать, чтобы график реагировал на выбор периода.
    //    Нужно написать функцию, которая по нажатию на кнопку будет убирать лишние объекты из массива chartPointModel
    
    let manager = StatisticsService(dataManager: MOCKDataService())
    let showErrorLabel: Bool
    let chartTimePeriods: [ChartTimePeriod]
    
    @State var chartPointModel: [ExerciseTypeStatisticsModel]
    
    init() {
        let objects = manager.getExerciseTypeStatistics(typeId: "Подтягивания")!.sorted { $0.date < $1.date }
        self.chartPointModel = objects
        
        if objects.count < 2 {
            showErrorLabel = true
        } else {
            showErrorLabel = false
        }
        
        let maxDifference = objects.last!.date.toInt - objects.first!.date.toInt
        let chartTimePeriods = StatisticsTestView.getChartTimePeriods(upTo: maxDifference)
        self.chartTimePeriods = chartTimePeriods
    }
    
    var body: some View {
        VStack {
            timePeriodSelection
            chart
        }
    }
    
    var timePeriodSelection: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(chartTimePeriods, id: \.self) { period in
                    Text("\(period.rawValue)")
                        .padding()
                        .background(.pink)
                }
            }
        }
    }
    
    
    var chart: some View {
        Chart {
            ForEach(chartPointModel) { chartPoint in
                LineMark (
                    x: .value("Day", chartPoint.date),
                    y: .value("Weight", chartPoint.maxWeight)
                )
            }
            .symbol(by: .value("Type", ""))
        }
        .aspectRatio(1.0, contentMode: .fit)
        .padding()
    }
    
    static func getChartTimePeriods(upTo seconds: Int) -> [ChartTimePeriod] {
        var periods: [ChartTimePeriod] = []
        
        for period in ChartTimePeriod.allCases.sorted(by: { $0.rawValue < $1.rawValue }) {
            if seconds >= period.rawValue {
                periods.append(period)
            } else {
                break
            }
        }
        return periods
    }
}




