import Foundation

class ProgramManager: ObservableObject {
        
    let storageService = ProgramStorageService()
    
    @Published var programs: [Program] = []
    
    init(exerciseManager: ExerciseManager) {
        loadPrograms()
    }
    
    func addProgram(_ program: Program) {
        programs.append(program)
        storageService.addProgram(program)
    }
    
    func loadPrograms() {
        if let programs = try? storageService.fetchPrograms() {
            self.programs = programs
        } else {
            self.programs = []
        }
    }
    
    func deleteProgram(byId id: String) {
        storageService.deleteProgram(byId: id)
        
        for index in programs.indices {
            if programs[index].id == id {
                programs.remove(at: index)
                print("DEBUG: Объект с id = \(id) найден и удален")
                return
            }
        }
        
        print("DEBUG: Объект с id = \(id) не найден!")

        
    }
    
    func updateProgram(with program: Program) {
        //  TODO: - Мб можно сделать более производительно
        deleteProgram(byId: program.id)
        addProgram(program)
    }
}
