import Foundation
import Combine

class SimpleStopwatchViewModel: ObservableObject {
    @Published var secondsElapsed: Int = 0
    private var timer: Timer?
    private var isRunning = false
    
    func start() {
        guard !isRunning else { return }
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.secondsElapsed += 1
        }
    }
    
    func stop() {
        guard isRunning else { return }
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    func reset() {
        stop()
        secondsElapsed = 0
    }
}
