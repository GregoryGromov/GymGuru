import SwiftUI

struct SimpleStopwatchView: View {
    @StateObject private var viewModel = SimpleStopwatchViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.secondsElapsed) секунд")
                .font(.largeTitle)
                .padding()
            
            HStack {
                Button(action: viewModel.start) {
                    Text("Старт")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DefaultButtonStyle())

                Button(action: viewModel.stop) {
                    Text("Стоп")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DefaultButtonStyle())
                
                Button(action: viewModel.reset) {
                    Text("Сброс")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DefaultButtonStyle())
            }
            .padding()
        }
    }
}
